//
//  WorkoutListItem.swift
//  BodyBooster
//
//  Created by ProDoctor on 21/12/23.
//

import SwiftUI

struct WorkoutListItem: View {
    var set: Workout.Set
    let action: () -> Void
    
    private var scale: CGFloat {
        self.set.status == .toDo ? 0.9 : 1
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
        .padding(-4)
        .scaleEffect(scale)
//        .opacity(0.6)
        .animation(.easeIn, value: scale)
    }
}

#Preview {
    WorkoutListItem(set: fakeTrainings[0].workouts[0].sets[0]) {}
}
