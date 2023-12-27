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
