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
    
    private var disabled: Bool {
        self.set.status != .doing
    }
    
    private var scale: Double {
        self.set.status == .doing ? 1 : 0.9
    }
    
    private var padding: Double {
        self.set.status == .doing ? 4 : 0
    }
    
    private var background: Color {
        switch self.set.status {
        case .doing: Color.patternRed
        case .toDo, .done: .gray
        }
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
        .padding(.vertical, padding)
        .scaleEffect(scale)
        .disabled(disabled)
    }
}

#Preview {
    WorkoutListItem(set: fakeTrainings[0].workouts[0].sets[0]) {}
}
