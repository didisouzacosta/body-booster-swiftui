//
//  TrainingHeader.swift
//  BodyBooster
//
//  Created by ProDoctor on 19/12/23.
//

import SwiftUI

struct TrainingHeader: View {
    
    let title: String
    let weekDays: [Int]
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(title)
                    .font(.system(size: 42, weight: .heavy))
                WeekDays(data: weekDays)
            }
            Spacer()
        }
    }
}

#Preview {
    TrainingHeader(title: "Cardio", weekDays: [1, 2])
}
