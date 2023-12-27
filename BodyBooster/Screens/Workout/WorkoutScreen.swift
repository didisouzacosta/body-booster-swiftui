//
//  WorkoutScreen.swift
//  BodyBooster
//
//  Created by ProDoctor on 21/12/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct WorkoutScreen: View {
    @Environment(TrainingStore.self) private var trainingStore
    @Environment(WorkoutRouter.self) private var router
    @Environment(\.dismiss) private var dismiss
    
    let identifier: any Identifiable<UUID>
    
    private var workout: Workout? {
        try? trainingStore.getWorkout(from: identifier)
    }
    
    var body: some View {
        if let workout {
            List {
                Section {
                    VStack(spacing: 16) {
                        Rectangle()
                            .fill(.white)
                            .overlay {
                                AnimatedImage(url: workout.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding()
                            }
                            .aspectRatio(1.6, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            .rounded()
                            .clipped()
                        
                        HStack {
                            Spacer()
                            VStack(alignment: .center) {
                                Text(workout.title)
                                    .font(.system(size: 22, weight: .heavy))
                                    .multilineTextAlignment(.center)
                                Text("\(workout.sets.count) series")
                            }
                            Spacer()
                        }
                    }
                }
                .minimalSection()
                
                Section {
                    StartButton() {}
                    ForEach(workout.sets) { set in
                        WorkoutListItem(set: set) {
                            updateToDoing(set: set)
                        }
                    }
                }
                .minimalSection()
                .padding(.vertical, -2)
            }
            .minimalList()
            .navigationTitle("\(0) de \(workout.sets.count)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Fechar") {
                        dismiss()
                    }
                }
            }
        } else {
            EmptyView()
        }
    }
    
    // MARK: - Private Methods
    
    private func updateToDoing(set: Workout.Set) {
        do {
            try trainingStore.update(status: .doing, in: set)
        } catch {
            print(error)
        }
    }
}

#Preview {
    WorkoutScreen(identifier: fakeTrainings[0].workouts[0])
        .environment(TrainingStore.preview)
        .environment(WorkoutRouter())
}
