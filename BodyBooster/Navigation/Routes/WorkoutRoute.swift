//
//  WorkoutRoute.swift
//  BodyBooster
//
//  Created by ProDoctor on 21/12/23.
//

import SwiftUI

typealias WorkoutRouter = Router<WorkoutRoute>

enum WorkoutRoute: RouteRepresentable {
    case instructions
    
    var isSheet: Bool {
        true
    }
    
    @ViewBuilder func content() -> some View {
        switch self {
        case .instructions: Text("Instructions")
        }
    }
}
