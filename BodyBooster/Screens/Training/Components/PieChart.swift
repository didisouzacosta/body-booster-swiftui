//
//  PieChartt.swift
//  BodyBooster
//
//  Created by ProDoctor on 19/12/23.
//

import SwiftUI
import Charts

struct PieChart: View {
    
    let done: Double
    let doing: Double
    let total: Double
    
    var todo: Double {
        total - (done + doing)
    }
    
    private var data: [Progress] {
        [
            Progress(count: done, color: Color.done),
            Progress(count: doing, color: Color.doing),
            Progress(count: todo, color: Color.patternInactive)
        ]
    }
    
    var body: some View {
        Chart(data, id: \.id) { element in
            SectorMark(
                angle: .value("Count", element.count),
                innerRadius: .ratio(0.5),
                angularInset: 0
            )
            .foregroundStyle(element.color)
        }
    }
    
}

extension PieChart {
    
    struct Progress: Identifiable {
        var id = UUID()
        var count: Double
        var color: Color
    }
    
}

#Preview {
    PieChart(done: 3, doing: 1, total: 100)
}
