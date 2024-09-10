//
//  NavigationRoute.swift
//
//
//  Created by Rodion Hladchenko on 10.09.2024.
//

import UIKit

public protocol NavigationRoute {
    var transitionType: AnimatedTransitioning? { get }
}

extension NavigationRoute {
    var transitionType: AnimatedTransitioning? {
        return nil
    }
}

public struct AnimatedTransitioning {
    var transitionTo: UIViewControllerAnimatedTransitioning? = nil
    var transitionFrom: UIViewControllerAnimatedTransitioning? = nil
}
