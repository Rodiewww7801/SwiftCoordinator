//
//  TabBarCoordinator.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 10.09.2024.
//

import SwiftCoordinator
import UIKit
import SwiftUI

enum TabsCoordinatorRoute: NavigationRoute {
    case red
    case green
    case blue
}

class TabBarController: UITabBarController, RouteProvider {
    var route: NavigationRoute? = nil
}

class TabBarItemsFactory: RouteTabBarFactoryProtocol {
    func view(for route: TabsCoordinatorRoute) -> UITabBarItem {
        switch route {
        case .red:
            UITabBarItem(
                title: "Red",
                image: UIImage(systemName: "pencil.tip"),
                tag: 0
            )
        case .green:
            UITabBarItem(
                title: "Green",
                image: UIImage(systemName: "pencil"),
                tag: 1
            )
        case .blue:
            UITabBarItem(
                title: "Blue",
                image: UIImage(systemName: "pencil.and.scribble"),
                tag: 2
            )
        }
    }
}

class TabBarCoordinator: Coordinator {
    private let router: RouterProtocol
    private let tabBarController = TabBarController()
    private let tabBarItemFactory = TabBarItemsFactory()
    var childCoordinators: [Coordinator] = []
    
    init(router: RouterProtocol) {
        self.router = router
        print("[TabBarCoordinator]: init")
    }
    
    deinit {
        print("[TabBarCoordinator]: deinit")
    }
    
    func start() {
        let tabViews: [TabsCoordinatorRoute] = [.red, .green, .blue]
        tabBarController.viewControllers = tabViews.map({ route in
            let viewController = self.factory(for: route)
            viewController.tabBarItem = tabBarItemFactory.factory(for: route)
            return viewController
        })
        self.router.push(tabBarController, animated: true)
    }
    
    private func tabBarItems(_ route: TabsCoordinatorRoute) -> UITabBarItem {
        return UITabBarItem()
    }
}

extension TabBarCoordinator: RouteViewFactoryProtocol {
    typealias Route = TabsCoordinatorRoute
    
    @ViewBuilder
    func view(for route: Route) -> some View {
        switch route {
        case .red:
            VStack {
                Circle()
                    .foregroundStyle(.red)
            }
            .padding(16)
        case .green:
            VStack {
                Circle()
                    .foregroundStyle(.green)
            }
            .padding(16)
        case .blue:
            VStack {
                Circle()
                    .foregroundStyle(.blue)
            }
            .padding(16)
        }
    }
}
