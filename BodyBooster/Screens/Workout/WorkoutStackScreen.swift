//
//  WorkoutStackScreen.swift
//  BodyBooster
//
//  Created by ProDoctor on 20/12/23.
//

import SwiftUI

struct WorkoutStackScreen: View {
    
    let workout: Workout
    
    private let router = WorkoutRouter()
    
    var body: some View {
        Navigator(router: router) {
            WorkoutScreen(workout: workout)
        }
        .environment(router)
    }
}

#Preview {
    WorkoutStackScreen(
        workout: fakeTrainings[0].workouts[0]
    )
}
