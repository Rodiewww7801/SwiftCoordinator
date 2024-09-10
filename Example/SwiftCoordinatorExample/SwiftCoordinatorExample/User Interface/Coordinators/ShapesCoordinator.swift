//
//  ShapesCoordinator.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 05.09.2024.
//

import SwiftCoordinator
import Foundation
import SwiftUI

enum ShapesRoute: NavigationRoute {
    case list
}

class ShapesCoordinator: Coordinator {
    private var router: RouterProtocol
    var childCoordinators: [Coordinator] = []
    
    init(_ router: RouterProtocol) {
        self.router = router
        print("[ShapesCoordinator]: init")
    }
    
    deinit {
        print("[ShapesCoordinator]: deinit")
    }
    
    func start() {
        showList()
    }
    
    private func showList() {
        let view = self.factory(for: .list)
        self.router.push(view, animated: true)
    }
    
    private func showSimpleShapesView() {
        let coordinator = dependency.coordinatorFactory.makeSimpleShapeCoordinator(self.router)
        coordinator.start()
    }
    
    private func showCustomShapesView() {
        let coordinator = dependency.coordinatorFactory.makeCustomShapeCoordinator(self.router)
        coordinator.start()
    }
    
    private func showFeatureShapeView(for route: NavigationRoute) {
        switch route {
        case let simpleShapeRoute as SimpleShapesRoute:
            let coordinator = dependency.coordinatorFactory.makeSimpleShapeCoordinator(self.router)
            let nextRoute: [SimpleShapesRoute] = [.list, simpleShapeRoute]
            coordinator.start(for: nextRoute)
            break
        case let customShapeRoute as CustomShapesRoute:
            let coordinator = dependency.coordinatorFactory.makeCustomShapeCoordinator(self.router)
            let nextRoute: [CustomShapesRoute] = [.list, customShapeRoute]
            coordinator.start(for: nextRoute)
            break
        default: return
        }
    }
    
    private func showTabsView() {
        let coordinator = TabBarCoordinator(router: self.router)
        coordinator.start()
    }
}


extension ShapesCoordinator: RouteFactoryProtocol {
    typealias Route = ShapesRoute
    
    func view(for route: ShapesRoute) -> some View {
        switch route {
        case .list:
            ShapeListView(coordinator: self)
        }
    }
}

extension ShapesCoordinator: ShapeListViewDelegate {
    func presentSimpleShapes() {
        self.showSimpleShapesView()
    }
    
    func presentCustomShapes() {
        self.showCustomShapesView()
    }
    
    func presentFeaturedShape(for route: NavigationRoute) {
        self.showFeatureShapeView(for: route)
    }
    
    func onTabs() {
        self.showTabsView()
    }
}
