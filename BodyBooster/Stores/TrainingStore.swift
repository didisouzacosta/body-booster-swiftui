//
//  TrainingStore.swift
//  BodyBooster
//
//  Created by ProDoctor on 17/12/23.
//

import SwiftUI
import Combine

@Observable
class TrainingStore {
    
    // MARK: - Public Variables
    
    private(set) var data = DataState<[Training], Error>.loaded([])
    
    // MARK: - Private Variables
    
    private let service: any TrainingService
    
    // MARK: - Life Cicle
    
    init(service: any TrainingService) {
        self.service = service
    }
    
    // MARK: - Public Methods
    
    func loadTrainings() async throws {
        data = .loading
        try await Task.sleep(seconds: 1)
        let trainings = try await service.getAll()
        data = .loaded(trainings)
    }
    
    func update(status: Workout.Set.Status, in set: Workout.Set) throws {
        var trainings = try data.value ?? []
        guard let index = try index(of: set) else { return }
        trainings[index.traning].workouts[index.workout].sets[index.set].status = status
        data = .loaded(trainings)
    }
    
    func getTraining(from identifier: some Identifiable<UUID>) throws -> Training? {
        (try data.value ?? []).first { $0.id == identifier.id }
    }
    
    func getWorkout(from identifier: some Identifiable<UUID>) throws -> Workout? {
        (try data.value ?? [])
            .flatMap { $0.workouts }
            .first { $0.id == identifier.id }
    }
    
    // MARK: Private Methods
    
    private func index(of set: Workout.Set) throws -> (traning: Int, workout: Int, set: Int)? {
        let trainings = try data.value ?? []
        
        var trainingIndex: Int?
        var workoutIndex: Int?
        var setIndex: Int?
        
        outerLoop: for trainingInteractor in trainings.enumerated() {
            trainingIndex = trainingInteractor.offset
            for workoutInteractor in trainingInteractor.element.workouts.enumerated() {
                workoutIndex = workoutInteractor.offset
                for setInteractor in workoutInteractor.element.sets.enumerated() {
                    setIndex = setInteractor.offset
                    if setInteractor.element.id == set.id {
                        break outerLoop
                    }
                }
            }
        }
        
        guard let trainingIndex, let workoutIndex, let setIndex else {
            return nil
        }
        
        return (trainingIndex, workoutIndex, setIndex)
    }
    
}

extension TrainingStore {
    
    static var preview: TrainingStore {
        let store = TrainingStore(service: TrainingServiceLocal())
        Task { try? await store.loadTrainings() }
        return store
    }
    
}
