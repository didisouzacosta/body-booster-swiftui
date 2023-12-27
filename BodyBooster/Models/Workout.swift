//
//  Workout.swift
//  BodyBooster
//
//  Created by ProDoctor on 17/12/23.
//

import Foundation

struct Workout: Identifiable, Codable, Hashable {
    let id = UUID()
    let title: String
    let image: URL
    
    var sets: [Workout.Set]
    
    enum CodingKeys: CodingKey {
        case title
        case image
        case sets
    }
    
}

extension Workout {
    
    struct Set: Codable, Hashable, Identifiable {
        let id = UUID()
        let repetitions: String
        let weight: String?
        let rest: Int?
        
        var status: Set.Status?
        
        enum CodingKeys: CodingKey {
            case repetitions
            case weight
            case rest
            case status
        }
    }
    
}

extension Workout.Set {
    
    enum Status: String, Codable {
        case todo
        case doing
        case done
    }
    
}
