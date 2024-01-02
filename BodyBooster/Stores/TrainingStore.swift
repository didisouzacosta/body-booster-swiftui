//
//  TrainingStore.swift
//  BodyBooster
//
//  Created by ProDoctor on 17/12/23.
//

import SwiftUI
import Combine

typealias Identifier = Identifiable<UUID>

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
        let trainings = try await service.getAll()
        data = .loaded(trainings)
    }
    
    func update(status: Workout.Set.Status, in set: Workout.Set) throws {
        var trainings = try data.value ?? []
        guard let index = try index(with: set) else { return }
        trainings[index.traning].workouts[index.workout].sets[index.set].status = status
        data = .loaded(trainings)
    }
    
    func getTraining(with identifier: some Identifier) throws -> Training? {
        (try data.value ?? []).first { $0.id == identifier.id }
    }
    
    func getWorkout(with identifier: some Identifier) throws -> Workout? {
        (try data.value ?? [])
            .flatMap { $0.workouts }
            .first { $0.id == identifier.id }
    }
    
    func getWorkoutSiblins(from identifier: some Identifier) throws -> [Workout] {
        let training = (try data.value ?? []).first { $0.workouts.contains { $0.id == identifier.id } }
        return training?.workouts ?? []
    }
    
    // MARK: Private Methods
    
    private func index(with set: Workout.Set) throws -> (traning: Int, workout: Int, set: Int)? {
        let trainings = try data.value ?? []
        
        var trainingIndex: Int?
        var workoutIndex: Int?
        var setIndex: Int?
        
        outerLoop: for trainingInteractor in trainings.enumerated() {
            for workoutInteractor in trainingInteractor.element.workouts.enumerated() {
                for setInteractor in workoutInteractor.element.sets.enumerated() {
                    if setInteractor.element.id == set.id {
                        trainingIndex = trainingInteractor.offset
                        workoutIndex = workoutInteractor.offset
                        setIndex = setInteractor.offset
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
