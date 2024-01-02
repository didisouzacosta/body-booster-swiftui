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
    
    let identifier: any Identifier
    
    @State private var tabSelection: UUID
    
    private var workouts: [Workout] {
        (try? trainingStore.getWorkoutSiblins(from: identifier)) ?? []
    }
    
    init(identifier: any Identifier) {
        self.identifier = identifier
        _tabSelection = State(wrappedValue: identifier.id)
    }
    
    var body: some View {
        ModelView {
            GeometryReader { geometry in
                ScrollView(.init()) {
                    TabView(selection: $tabSelection) {
                        ForEach(workouts.enumaredArray(), id: \.element.id) { index, workout in
                            ScrollView {
                                SetScreen(workout: workout) {
                                    next(position: index + 1)
                                }
                                .padding()
                                .safeAreaPadding(.bottom, geometry.safeAreaInsets.bottom)
                            }
                            .scrollIndicators(.hidden)
                            .tag(workout.id)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .animation(.easeOut(duration: 0.2), value: tabSelection)
                }
                .scrollIndicators(.hidden)
                .ignoresSafeArea(.container, edges: .bottom)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func next(position: Int) {
        if let next = workouts[safe: position]?.id {
            tabSelection = next
        } else {
            dismiss()
        }
    }
    
}

#Preview {
    WorkoutScreen(identifier: fakeTrainings[0].workouts[0])
        .environment(TrainingStore.preview)
        .environment(WorkoutRouter())
}
