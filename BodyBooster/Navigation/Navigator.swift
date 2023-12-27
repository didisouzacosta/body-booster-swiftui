//
//  Navigator.swift
//  BodyBooster
//
//  Created by ProDoctor on 18/12/23.
//

import SwiftUI

struct Navigator<Content: View, Router: RouterRepresentable>: View {
    @State var router: Router
    
    let content: () -> Content
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content()
                .navigationDestination(for: Router.Route.self) { $0.content() }
                .sheet(item: $router.sheet) { $0.content() }
        }
    }
    
    // MARK: - Life Cicle
    
    init(
        router: Router,
        @ViewBuilder content: @escaping () -> Content
    ) {
        _router = State(initialValue: router)
        self.content = content
    }
}
