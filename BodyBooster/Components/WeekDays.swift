//
//  WeekDays.swift
//  BodyBooster
//
//  Created by ProDoctor on 19/12/23.
//

import SwiftUI

struct WeekDays: View {
    
    let data: [Int]
    
    var body: some View {
        let weekDays = data.map { WeekDay(day: $0) }
        
        HStack {
            ForEach(weekDays, id: \.day) { weekDay in
                let showSeparator = weekDay.day != data.last
                
                Text(weekDay.symbol)
                    .bold(weekDay.isActive)
                
                if showSeparator {
                    Text("/")
                }
            }
            .font(.system(size: 14))
        }
    }
    
}

extension WeekDays {
    
    struct WeekDay: Identifiable {
        let id = UUID()
        let day: Int
        
        var symbol: String {
            String(Calendar.current.weekdaySymbols[day].prefix(3))
        }
        
        var isActive: Bool {
            Date().weekDay() == day
        }
    }
    
}

#Preview {
    WeekDays(data: [3, 4])
}
