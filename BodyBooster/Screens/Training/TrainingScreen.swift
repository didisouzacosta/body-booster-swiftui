//
//  TrainingScreen.swift
//  BodyBooster
//
//  Created by ProDoctor on 19/12/23.
//

import SwiftUI

struct TrainingScreen: View {
    @Environment(TrainingStore.self) private var trainingStore
    @Environment(MainRouter.self) private var router
    
    let identifier: any Identifiable<UUID>
    
    private var training: Training? {
        try? trainingStore.getTraining(with: identifier)
    }
    
    private var title: String {
        training?.title ?? ""
    }
    
    private var weekDays: [Int] {
        training?.weekDays ?? []
    }
    
    private var workouts: [Workout] {
        training?.workouts ?? []
    }
    
    var body: some View {
        List {
            Section {
                TrainingHeader(
                    title: title,
                    weekDays: weekDays
                )
            }
            .minimalSection()
            
            Section {
                ForEach(Array(workouts.enumerated()), id: \.offset) { index, workout in
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
    TrainingScreen(identifier: fakeTrainings[0])
        .environment(TrainingStore.preview)
        .environment(MainRouter())
}
