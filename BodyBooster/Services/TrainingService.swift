//
//  TrainingService.swift
//  BodyBooster
//
//  Created by ProDoctor on 17/12/23.
//

import Foundation
import Combine

protocol Service<T> {
    associatedtype T
}

protocol TrainingService: Service where T == Training {
    func getAll() async throws -> [T]
}

struct TrainingServiceLocal: TrainingService {
    
    // MARK: - Public Methods
    
    func getAll() async throws -> [T] {
        fakeTrainings
    }
    
}
