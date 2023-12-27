//
//  HomeScreen.swift
//  BodyBooster
//
//  Created by ProDoctor on 17/12/23.
//

import SwiftUI

struct HomeScreen: View {
    @Environment(MainRouter.self) var router
    @Environment(TrainingStore.self) private var trainingStore
    
    var body: some View {
        HomeList(trainings: trainingStore.data) { training in
            router.navigate(to: .training(training))
        }
        .navigationTitle("")
        .onFirstAppear {
            Task {
                do {
                    try await trainingStore.loadTrainings()
                } catch {
                    print(error)
                }
            }
        }
    }
}

#Preview {
    HomeScreen()
        .environment(MainRouter())
        .environment(TrainingStore.preview)
}
