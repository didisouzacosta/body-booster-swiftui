//
//  Router.swift
//  BodyBooster
//
//  Created by ProDoctor on 18/12/23.
//

import SwiftUI

protocol RouterRepresentable: Observable {
    associatedtype Route: RouteRepresentable
    
    var path: NavigationPath { get set }
    var sheet: Route? { get set }
    
    func navigate(to route: Route)
    func pop()
}

@Observable
final class Router<Route: RouteRepresentable>: RouterRepresentable {
    var path = NavigationPath()
    var sheet: Route?
    
    func navigate(to route: Route) {
        if route.isSheet {
            sheet = route
        } else {
            path.append(route)
        }
    }
    
    func pop() {
        path.removeLast()
    }
}
