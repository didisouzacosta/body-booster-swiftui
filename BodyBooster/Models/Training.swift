//
//  Training.swift
//  BodyBooster
//
//  Created by ProDoctor on 17/12/23.
//

import Foundation

struct Training: Codable, Identifiable, Hashable {
    let id = UUID()
    let title: String
    let weekDays: [Int]
    
    var workouts: [Workout]
    
    enum CodingKeys: CodingKey {
        case title
        case weekDays
        case workouts
    }
}
