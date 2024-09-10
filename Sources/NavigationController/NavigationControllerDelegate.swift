//
//  NavigationControllerDelegate.swift
//  
//
//  Created by Rodion Hladchenko on 10.09.2024.
//

import UIKit

class NavigationControllerTransitionHandler {
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
            var transition: UIViewControllerAnimatedTransitioning? = nil
            if let routeProvider = toVC as? RouteProvider, let route = routeProvider.route {
                transition = route.transitionType?.transitionTo
            }
            if let routeProvider = fromVC as? RouteProvider, let route = routeProvider.route, transition == nil {
                transition = route.transitionType?.transitionFrom
            }
            return transition
        }
}

class NavigationControllerDelegateProxy: NSObject, UINavigationControllerDelegate {
    public let transitionHandler: NavigationControllerTransitionHandler
    
    public init(transitionHandler: NavigationControllerTransitionHandler) {
        self.transitionHandler = transitionHandler
    }
    
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
            return transitionHandler.navigationController(
                navigationController,
                animationControllerFor: operation,
                from: fromVC,
                to: toVC)
    }
}
