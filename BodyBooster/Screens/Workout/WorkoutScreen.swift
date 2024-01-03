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
        ModalView {
            VStack {
                HStack {
                    ForEach(workouts.compactMap { $0.id }, id: \.self) { id in
                        Rectangle()
                            .fill(.green)
                            .opacity(stepOpacity(id))
                            .frame(width: stepWidth(id), height: 4)
                            .rounded()
                    }
                }
                .safeAreaPadding(.horizontal)
                .padding(.horizontal)
                .padding(.vertical, 4)
                .animation(.easeInOut, value: tabSelection)
                
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
    }
    
    // MARK: - Private Methods
    
    private func next(position: Int) {
        if let next = workouts[safe: position]?.id {
            tabSelection = next
        } else {
            dismiss()
        }
    }
    
    private func stepWidth(_ id: UUID) -> CGFloat {
        id == tabSelection ? 60 : .infinity
    }
    
    private func stepOpacity(_ id: UUID) -> CGFloat {
        id == tabSelection ? 1 : 0.4
    }
    
}

#Preview {
    WorkoutScreen(identifier: fakeTrainings[0].workouts[0])
        .environment(TrainingStore.preview)
        .environment(WorkoutRouter())
        .preferredColorScheme(.dark)
}

#Preview {
    WorkoutScreen(identifier: fakeTrainings[0].workouts[0])
        .environment(TrainingStore.preview)
        .environment(WorkoutRouter())
        .preferredColorScheme(.light)
}
