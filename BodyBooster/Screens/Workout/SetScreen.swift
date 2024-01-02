//
//  SetScreen.swift
//  BodyBooster
//
//  Created by ProDoctor on 02/01/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct SetScreen: View {
    
    @Environment(TrainingStore.self) private var trainingStore
    
    // MARK: - Public Variables
    
    let workout: Workout
    let dismiss: () -> Void
    
    var body: some View {
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
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
    
    // MARK: - Private Variables
    
    private var sets: [Workout.Set] {
        workout.sets
    }
    
    private var isStarted: Bool {
        sets.contains { $0.status == .doing }
    }
    
    private var isCompleted: Bool {
        sets.allSatisfy { $0.status == .done }
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
    SetScreen(workout: fakeTrainings[0].workouts[0]) {}
        .environment(TrainingStore.preview)
}
