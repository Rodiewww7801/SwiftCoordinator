//
//  CustomShapesCoordinator.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 05.09.2024.
//

import SwiftCoordinator
import Foundation
import SwiftUI

enum CustomShapesRoute: NavigationRoute {
    case list
    case triangle
    case star
    case tower
    
    var transitionType: AnimatedTransitioning? {
        AnimatedTransitioning(transitionTo: self.transitionTo, transitionFrom: self.transitionFrom)
    }
    
    var transitionTo: UIViewControllerAnimatedTransitioning? {
        if case self = .star {
            return FadeTransition()
        }
        return nil
    }
    
    var transitionFrom: UIViewControllerAnimatedTransitioning? {
        if case self = .star {
            return FadeTransition()
        }
        return nil
    }
}

class CustomShapesCoordinator: Coordinator {
    private var router: RouterProtocol
    var childCoordinators: [Coordinator] = []
    
    init(_ router: RouterProtocol) {
        self.router = router
        print("[CustomShapesCoordinator]: init")
    }
    
    deinit {
        print("[CustomShapesCoordinator]: deinit")
    }
    
    func start() { 
        self.showList()
    }
    
    func start(for route: [NavigationRoute]) {
        guard let route = route as? [CustomShapesRoute] else { return }
        let views = route.map{ self.factory(for: $0) }
        self.router.push(views, animated: true)
    }
    
    private func showList() {
        let view = self.factory(for: .list)
        self.router.push(view, animated: true)
    }
    
    private func showTriangle() {
        let view = self.factory(for: .triangle)
        self.router.push(view, animated: true)
    }
    
    private func showStar() {
        let view = self.factory(for: .star)
        self.router.push(view, animated: true)
    }
    
    private func showTower() {
        let view = self.factory(for: .tower)
        self.router.push(view, animated: true)
    }
}

extension CustomShapesCoordinator: RouteFactoryProtocol {
    typealias Route = CustomShapesRoute

    @ViewBuilder
    func view(for route: Route) -> some View {
        switch route {
        case .list:
            CustomShapesView(delelgate: self)
        case .triangle:
            TriangleView()
        case .star:
            StarView()
        case .tower:
            TowerView()
        }
    }
}

extension CustomShapesCoordinator: CustomShapesViewDelegate {
    func presentTriangle() {
        self.showTriangle()
    }
    
    func presentStar() {
        self.showStar()
    }
    
    func presentTower() {
        self.showTower()
    }
}
