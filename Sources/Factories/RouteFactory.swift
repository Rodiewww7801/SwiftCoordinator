//
//  RouteFactory.swift
//  
//
//  Created by Rodion Hladchenko on 10.09.2024.
//

import SwiftUI
import UIKit

public protocol RouteFactoryProtocol {
    associatedtype Route: NavigationRoute
    associatedtype V

    func view(for route: Route) -> V
}

extension RouteFactoryProtocol where V: View  {
    func factory(for route: Route) -> Presentable {
        let view = self.view(for: route)
        let wrappedView = self.wrapView(route: route, rootView: view)
        return wrappedView
    }
    
    private func wrapView(route: Route, rootView: V) -> Presentable {
        let wrappedView = RouteHostingController(route: route, rootView: rootView)
        return wrappedView
    }
}

extension RouteFactoryProtocol where V: Presentable {
    func factory(for route: Route) -> Presentable {
        let viewController = self.view(for: route)
        return viewController
    }
}

public protocol RouteViewControllerFactoryProtocol: RouteFactoryProtocol {
    func view(for route: Route) -> UIViewController
}

public protocol RouteViewFactoryProtocol: RouteFactoryProtocol {
    func view(for route: Route) -> V
}

public protocol RouteTabBarFactoryProtocol: RouteFactoryProtocol {
    func view(for route: Route) -> UITabBarItem
}

extension RouteFactoryProtocol where V: UITabBarItem {
    func factory(for route: Route) -> UITabBarItem {
        let viewController = self.view(for: route)
        return viewController
    }
}

