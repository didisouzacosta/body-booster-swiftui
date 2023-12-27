//
//  TrainingListItem.swift
//  BodyBooster
//
//  Created by ProDoctor on 19/12/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct TrainingListItem: View {
    
    let index: Int
    let workout: Workout
    
    var body: some View {
        HStack(spacing: 16) {
            Text("\(index + 1)")
                .font(.system(size: 12))
                .frame(width: 30)
            AnimatedImage(url: workout.image)
                .resizable()
                .frame(width: 40, height: 40)
                .aspectRatio(contentMode: .fit)
                .rounded(6)
            VStack(alignment: .leading, spacing: 4) {
                Text(workout.title)
                    .font(.system(size: 16, weight: .bold))
                Text("\(done) de \(workout.sets.count) series")
                    .font(.system(size: 12))
            }
            Spacer()
            PieChart(
                done: Double(done),
                doing: Double(doing),
                total: Double(total)
            )
            .frame(width: 20, height: 20)
        }
        .padding()
        .background(Color.backgroundLight)
        .rounded()
        .opacity(isCompled ? 0.4 : 1)
    }
    
    private var done: Int {
        workout.sets.filter { $0.status == .done }.count
    }
    
    private var doing: Int {
        workout.sets.filter { $0.status == .doing }.count
    }
    
    private var total: Int {
        workout.sets.count
    }
    
    private var isCompled: Bool {
        done == total
    }
    
}

#Preview {
    TrainingListItem(index: 1, workout: fakeTrainings[0].workouts[0])
}
