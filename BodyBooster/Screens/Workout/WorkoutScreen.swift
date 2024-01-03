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
    
    @State private var selectedItem: UUID
    
    private var workouts: [Workout] {
        (try? trainingStore.getWorkoutSiblins(from: identifier)) ?? []
    }
    
    private var currentIndex: Int {
        workouts.firstIndex { $0.id == selectedItem } ?? 0
    }
    
    private var total: Int {
        workouts.count
    }
    
    private var title: String {
        "\(currentIndex + 1) de \(total)"
    }
    
    init(identifier: any Identifier) {
        self.identifier = identifier
        _selectedItem = State(wrappedValue: identifier.id)
    }
    
    var body: some View {
        ModalView {
            VStack {
                HStack {
                    ForEach(workouts.compactMap { $0.id }, id: \.self) { id in
                        Rectangle()
                            .fill(.green)
                            .opacity(stepOpacity(id))
                            .frame(minWidth: 0, maxWidth: stepWidth(id), maxHeight: 4)
                            .rounded()
                            .onTapGesture {
                                selectedItem = id
                            }
                    }
                }
                .safeAreaPadding(.horizontal)
                .padding(.horizontal, 32)
                .padding(.vertical, 4)
                .animation(.easeInOut, value: selectedItem)
                
                GeometryReader { geometry in
                    ScrollView(.init()) {
                        TabView(selection: $selectedItem) {
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
                        .animation(.easeInOut, value: selectedItem)
                    }
                    .scrollIndicators(.hidden)
                    .ignoresSafeArea(.container, edges: .bottom)
                }
            }
        }
        .navigationTitle(title)
    }
    
    // MARK: - Private Methods
    
    private func next(position: Int) {
        if let next = workouts[safe: position]?.id {
            selectedItem = next
        } else {
            dismiss()
        }
    }
    
    private func stepWidth(_ id: UUID) -> CGFloat {
        id == selectedItem ? .infinity : 24
    }
    
    private func stepOpacity(_ id: UUID) -> CGFloat {
        id == selectedItem ? 1 : 0.4
    }
    
}

#Preview {
    WorkoutScreen(identifier: fakeTrainings[0].workouts[0])
        .environment(TrainingStore.preview)
        .environment(WorkoutRouter())
        .preferredColorScheme(.dark)
}
