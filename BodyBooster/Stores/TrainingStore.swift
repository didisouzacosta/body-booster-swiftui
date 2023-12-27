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
    
    private(set) var trainings = DataState<[Training], Error>.loaded([])
    
    // MARK: - Private Variables
    
    private let service: any TrainingService
    
    // MARK: - Life Cicle
    
    init(service: any TrainingService) {
        self.service = service
    }
    
    // MARK: - Public Methods
    
    func loadTrainings() async throws {
        trainings = .loading
        try await Task.sleep(seconds: 1)
        let data = try await service.getAll()
        trainings = .loaded(data)
    }
    
}

extension TrainingStore {
    
    static var preview: TrainingStore {
        .init(service: TrainingServiceLocal())
    }
    
}
