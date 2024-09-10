//
//  SimpleShapesCoordinator.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 05.09.2024.
//

import SwiftCoordinator
import Foundation
import SwiftUI

enum SimpleShapesRoute: NavigationRoute {
    case list
    case rect
    case roundedRect
    case capsule
    case elipse
    case circle
    
    var transitionType: AnimatedTransitioning {
        return AnimatedTransitioning(transitionTo: self.transitionTo, transitionFrom: self.transitionFrom)
    }
    
    var transitionTo: UIViewControllerAnimatedTransitioning? {
        if case self = .roundedRect {
            return SlideTransition(for: .presenting)
        }
        return nil
    }
    
    var transitionFrom: UIViewControllerAnimatedTransitioning? {
        if case self = .roundedRect {
            return SlideTransition(for: .dismissing)
        }
        return nil
    }
}

class SimpleShapesCoordinator: Coordinator {
    private var router: RouterProtocol
    var childCoordinators: [Coordinator] = []
    
    
    init(_ router: RouterProtocol) {
        self.router = router
        print("[SimpleShapesCoordinator]: init")
    }
    
    deinit {
        print("[SimpleShapesCoordinator]: deinit")
    }
    
    func start() { 
        self.showList()
    }
    
    func start(for route: [NavigationRoute]) {
        guard let route = route as? [SimpleShapesRoute] else { return }
        let views = route.map{ self.factory(for: $0) }
        self.router.push(views, animated: true)
    }
    
    private func showList() {
        let view = self.factory(for: .list)
        self.router.push(view, animated: true)
    }
    
    private func showRectView() {
        let view = self.factory(for: .rect)
        self.router.present(view, withDelegate: nil, animated: true)
    }
    
    private func showRoundedRect() {
        let view = self.factory(for: .roundedRect)
        self.router.present(view, animated: true)
    }
    
    private func showCapsule() {
        let view =  self.factory(for: .capsule)
        self.router.push(view, animated: true)
    }
    
    private func showEllipse() {
        let view = self.factory(for: .elipse)
        self.router.push(view, animated: true)
    }
    
    private func showCircle() {
        let view = self.factory(for: .circle)
        self.router.push(view, animated: true)
    }
}

extension SimpleShapesCoordinator: RouteFactoryProtocol {
    typealias Route = SimpleShapesRoute
    
    @ViewBuilder
    func view(for route: Route) -> some View {
        switch route {
        case .list:
            SimpleShapesListView(coordinator: self)
        case .rect:
            RectView(coordinator: self)
        case .roundedRect:
            let onDismiss = { [weak self] in
                guard let self = self else { return}
                self.router.pop(animated: true)
            }
            RoundRectView(onDismiss: onDismiss)
        case .capsule:
            CapsuleView()
        case .elipse:
            ElipseView()
        case .circle:
            CircleView(coordinator: self)
        }
    }
}

extension SimpleShapesCoordinator: SimpleShapesViewDelegate {
    func presentRect() {
        self.showRectView()
    }
    
    func presentRoundedRect() {
        self.showRoundedRect()
    }
    
    func presentCapsule() {
        self.showCapsule()
    }
    
    func presentEllipse() {
        self.showEllipse()
    }
    
    func presentCircle() {
        self.showCircle()
    }
}

extension SimpleShapesCoordinator: RectViewDelegate {
    func dismiss() {
        self.router.pop(animated: true)
    }
}

extension SimpleShapesCoordinator: CircleViewDelegate {
    func onDone() {
        self.router.popToRoot(animated: true)
    }
}
