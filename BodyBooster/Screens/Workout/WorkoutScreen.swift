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
        try? trainingStore.getWorkout(with: identifier)
    }
    
    private var sets: [Workout.Set] {
        workout?.sets ?? []
    }
    
    private var isStarted: Bool {
        sets.contains { $0.status == .doing }
    }
    
    private var isCompleted: Bool {
        sets.allSatisfy { $0.status == .done }
    }
    
    var body: some View {
        if let workout {
            ScrollView {
                LazyVStack {
                    VStack(spacing: 16) {
                        Rectangle()
                            .fill(.white)
                            .overlay {
                                AnimatedImage(url: workout.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding()
                            }
                            .aspectRatio(1.6, contentMode: .fill)
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
                    .padding(.bottom, 8)
                    
                    StartButton(isStarted, isCompleted: isCompleted) {
                        startWorkout()
                    }
                    
                    ForEach(sets.enumaredArray(), id: \.element.id) { index, set in
                        WorkoutListItem(set: set) {
                            setAction(set, index: index)
                        }
                    }
                    .padding(.vertical, -4)
                }
                .padding()
            }
            .scrollIndicators(.hidden)
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
    
    private func startWorkout() {
        sets.enumerated().forEach { index, set in
            if index == 0 {
                updateToDoing(set)
            } else {
                updateToToDo(set)
            }
        }
    }
    
    private func setAction(_ set: Workout.Set, index: Int) {
        updateToDone(set)
        
        if let nextSet = sets[safe: index + 1] {
            updateToDoing(nextSet)
        } else {
            dismiss()
        }
    }
    
    private func updateToToDo(_ set: Workout.Set) {
        try? trainingStore.update(status: .toDo, in: set)
    }
    
    private func updateToDoing(_ set: Workout.Set) {
        try? trainingStore.update(status: .doing, in: set)
    }
    
    private func updateToDone(_ set: Workout.Set) {
        try? trainingStore.update(status: .done, in: set)
    }
}

#Preview {
    WorkoutScreen(identifier: fakeTrainings[0].workouts[0])
        .environment(TrainingStore.preview)
        .environment(WorkoutRouter())
}
