//
//  Coordinator.swift
//  
//
//  Created by Rodion Hladchenko on 10.09.2024.
//

import UIKit

public protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
    func start(for route: [NavigationRoute])
    func add(child: Coordinator)
    func remove(_ coordinator: Coordinator)
    func remove()
}

extension Coordinator {
    func start(for route: [NavigationRoute]) {
        fatalError("[Coordinator]: Not implemented")
    }
}

extension Coordinator {
    func add(child: Coordinator) {
        guard !childCoordinators.contains(where: { $0 === child }) else { return }
        childCoordinators.append(child)
    }
    
    func remove(_ coordinator: Coordinator) {
        coordinator.remove()
        self.childCoordinators.removeAll(where: { $0 === coordinator })
    }
    
    func remove() {
        if childCoordinators.isEmpty {
            return
        }
        self.childCoordinators.forEach { child in
            child.remove()
        }
        childCoordinators.removeAll()
    }
}
