//
//  WorkoutListItem.swift
//  BodyBooster
//
//  Created by ProDoctor on 21/12/23.
//

import SwiftUI

struct WorkoutListItem: View {
    
    let set: Workout.Set
    let action: () -> Void
    
    @State private var scale: Double = 0.9
    @State private var padding: Double = 0
    @State private var opacity: Double = 1
    @State private var background: Color = .gray
    
    private var disabled: Bool {
        self.set.status != .doing
    }
    
    private var foregroundColor: Color {
        switch self.set.status {
        case .doing: .white
        case .toDo, .done: Color.primary
        }
    }
    
    var body: some View {
        TouchableButton(content: {
            HStack(spacing: 24) {
                Spacer()
                VStack {
                    Text("Repetições")
                        .font(.system(size: 14))
                    Text(set.repetitions)
                        .font(.system(size: 20, weight: .bold))
                }
                VStack {
                    Text("Carga")
                        .font(.system(size: 14))
                    Text("\(set.weight ?? "0")kg")
                        .font(.system(size: 20, weight: .bold))
                }
                VStack {
                    Text("Descanso")
                        .font(.system(size: 14))
                    Text("\(set.rest ?? 0)min")
                        .font(.system(size: 20, weight: .bold))
                }
                Spacer()
            }
            .padding(16)
            .background(background)
            .foregroundColor(foregroundColor)
            .rounded()
        }, action: action)
        .disabled(disabled)
        .scaleEffect(scale)
        .opacity(opacity)
        .padding(.vertical, padding)
        .onChange(of: set.status, initial: true) { _, newValue in
            DispatchQueue.main.async {
                withAnimation(.easeOut) {
                    scale = newValue == .doing ? 1 : 0.9
                    opacity = newValue == .done ? 0.6 : 1
                    padding = newValue == .doing ? 8 : 0
                    background = newValue == .doing ? Color.patternRed : .gray
                }
            }
        }
    }
    
}

#Preview {
    WorkoutListItem(set: fakeTrainings[0].workouts[0].sets[0]) {}
}
