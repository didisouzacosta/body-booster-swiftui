//
//  FakeData.swift
//  BodyBooster
//
//  Created by ProDoctor on 19/12/23.
//

import Foundation

var fakeTrainings: [Training] {
    guard let file = Bundle.main.url(
        forResource: "trainings",
        withExtension: "json"
    ) else { return [] }
    
    guard let data = try? Data(contentsOf: file) else {
        return []
    }
    
    let decoder = JSONDecoder()
    
    return (try? decoder.decode([Training].self, from: data)) ?? []
}
