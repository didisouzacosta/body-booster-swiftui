//
//  MainStackScreen.swift
//  BodyBooster
//
//  Created by ProDoctor on 19/12/23.
//

import SwiftUI

struct MainStackScreen: View {
    private let router = MainRouter()
    
    var body: some View {
        Navigator(
            router: router,
            content: {
                HomeScreen()
            }
        )
        .environment(router)
    }
}

#Preview {
    MainStackScreen()
        .environment(TrainingStore.preview)
        .preferredColorScheme(.dark)
}
