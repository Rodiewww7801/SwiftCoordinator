//
//  RouteProvider.swift
//
//
//  Created by Rodion Hladchenko on 10.09.2024.
//

import SwiftUI

public protocol RouteProvider {
    var route: NavigationRoute? { get }
}

public class RouteHostingController<Content: View>: UIHostingController<Content>, RouteProvider {
    public let route: NavigationRoute?
    
    init(route: NavigationRoute, rootView: Content) {
        self.route = route
        super.init(rootView: rootView)
    }
    
    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

