//
//  MainRoute.swift
//  BodyBooster
//
//  Created by ProDoctor on 21/12/23.
//

import SwiftUI

typealias MainRouter = Router<MainRoute>

enum MainRoute: RouteRepresentable {
    case training(Training)
    case workout(Workout)
    
    var isSheet: Bool {
        switch self {
        case .workout: true
        default: false
        }
    }
    
    @ViewBuilder func content() -> some View {
        switch self {
        case .training(let training): TrainingScreen(training: training)
        case .workout(let workout): WorkoutStackScreen(workout: workout)
        }
    }
}
