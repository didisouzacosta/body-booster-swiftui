//
//  HomeListItem.swift
//  BodyBooster
//
//  Created by ProDoctor on 18/12/23.
//

import SwiftUI
import Charts

struct HomeListItem: View {
    
    // MARK: - Public Variables
    
    let training: Training
    
    // MARK: - Private Variables
    
    private var sets: [Workout.Set] {
        training.workouts.flatMap { $0.sets }
    }
    
    private var total: Int {
        sets.count
    }
    
    private var doing: Int {
        sets.filter { $0.status == .doing }.count
    }
    
    private var done: Int {
        sets.filter { $0.status == .done }.count
    }
    
    private var toDo: Int {
        total - (done + doing)
    }
    
    private var percentage: Double {
        Double(done) / Double(total) * 100
    }
    
    private var data: [Progress] {
        [
            Progress(count: Double(done), color: Color.done),
            Progress(count: Double(doing), color: Color.doing),
            Progress(count: Double(toDo), color: Color.patternInactive)
        ]
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(training.title)
                .font(.system(size: 18))
                .bold()
            
            Chart(data, id: \.id) { item in
                BarMark(
                    x: .value("Progress", item.count),
                    stacking: .center
                )
                .foregroundStyle(item.color)
                .cornerRadius(8)
            }
            .frame(height: 4)
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            
            HStack{
                HStack() {
                    Text("\(done)").bold()
                    Text("de")
                    HStack(spacing: 2) {
                        Text("\(total)").bold()
                        Text("series")
                    }
                }
                Spacer()
                Text("\(percentage.roundTo(decimalPlaces: 0))%")
            }
        }
        .padding()
        .background(.backgroundLight)
        .rounded()
    }
}

extension HomeListItem {
    
    struct Progress: Identifiable {
        var id = UUID()
        var count: Double
        var color: Color
    }
    
}

extension Double {
    
    func roundTo(decimalPlaces: Int) -> String {
        return NSString(format: "%.\(decimalPlaces)f" as NSString, self) as String
    }
    
}

#Preview {
    HomeListItem(training: fakeTrainings[0])
}
