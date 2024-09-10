//
//  AppCoordinator.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 04.09.2024.
//

import SwiftCoordinator
import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    private(set) weak var parent: Coordinator? = nil
    var childCoordinators = [Coordinator]()
    
    private(set) var window: UIWindow
    private(set) var navigationController: UINavigationController
    private(set) var router: RouterProtocol
    
    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
        
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
        self.router = dependency.routerFactory.makeAppRouter(navigationController)
        print("[AppCoordinator]: init")
    }
    
    deinit {
        print("[AppCoordinator]: deinit") // never call
    }
    
    func start() {
        let shapeCoordinator = dependency.coordinatorFactory.makeShapeCoordinator(self.router)
        shapeCoordinator.start()
    }
}
