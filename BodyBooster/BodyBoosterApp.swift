//
//  BodyBoosterApp.swift
//  BodyBooster
//
//  Created by ProDoctor on 17/12/23.
//

import SwiftUI

@main
struct BodyBoosterApp: App {
    @State private var trainingStore = TrainingStore.preview
    
    var body: some Scene {
        WindowGroup {
            MainStackScreen()
        }
        .environment(trainingStore)
    }
}
