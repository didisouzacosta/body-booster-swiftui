//
//  WorkoutStackScreen.swift
//  BodyBooster
//
//  Created by ProDoctor on 20/12/23.
//

import SwiftUI

struct WorkoutStackScreen: View {
    @Environment(TrainingStore.self) private var trainingStore
    
    let identifier: any Identifiable<UUID>
    
    private let router = WorkoutRouter()
    
    var body: some View {
        Navigator(router: router) {
            WorkoutScreen(identifier: identifier)
        }
        .environment(router)
    }
}

#Preview {
    WorkoutStackScreen(identifier: fakeTrainings[0].workouts[0])
        .environment(TrainingStore.preview)
}
