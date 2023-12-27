//
//  TrainingScreen.swift
//  BodyBooster
//
//  Created by ProDoctor on 19/12/23.
//

import SwiftUI

struct TrainingScreen: View {
    @Environment(MainRouter.self) var router
    
    let training: Training
    
    var body: some View {
        List {
            Section {
                TrainingHeader(
                    title: training.title,
                    weekDays: training.weekDays
                )
            }
            .minimalSection()
            
            Section {
                ForEach(Array(training.workouts.enumerated()), id: \.offset) { index, workout in
                    TouchableButton(content: {
                        TrainingListItem(index: index, workout: workout)
                    }) {
                        router.navigate(to: .workout(workout))
                    }
                }
            }
            .minimalSection()
        }
        .navigationTitle("Treino")
        .minimalList()
    }
}


#Preview {
    TrainingScreen(training: fakeTrainings[0])
        .environment(MainRouter())
}
