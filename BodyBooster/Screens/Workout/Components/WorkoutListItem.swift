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
            .background(Color.patternRed)
            .foregroundColor(.white)
            .rounded()
        }, action: action)
        .disabled(disabled)
    }
}

#Preview {
    WorkoutListItem(set: fakeTrainings[0].workouts[0].sets[0]) {}
}
