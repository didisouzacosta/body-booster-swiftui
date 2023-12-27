//
//  DataState.swift
//  BodyBooster
//
//  Created by ProDoctor on 19/12/23.
//

import Foundation

enum DataState<T, E: Error> {
    case loading
    case loaded(T)
    case failure(E)
}

extension DataState {
    
    var value: T? {
        get throws {
            switch self {
            case .failure(let error): throw error
            case .loading: nil
            case .loaded(let data): data
            }
        }
    }
    
}
