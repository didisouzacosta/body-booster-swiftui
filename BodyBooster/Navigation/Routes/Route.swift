//
//  Route.swift
//  BodyBooster
//
//  Created by ProDoctor on 20/12/23.
//

import SwiftUI

protocol RouteRepresentable: Hashable, Identifiable {
    associatedtype View: SwiftUI.View
    
    var isSheet: Bool { get }
    
    @ViewBuilder func content() -> View
}

extension RouteRepresentable {
    var id: Self { self }
}
