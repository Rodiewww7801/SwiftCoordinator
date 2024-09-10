//
//  CoordinatorFactory.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 05.09.2024.
//

import SwiftCoordinator
import Foundation
import UIKit

class CoordinatorFactory: CoordinatorFactoryProtocol {
    var appCoordinator: Coordinator? = nil
    
    func makeAppCoordinator(window: UIWindow, navigationController: UINavigationController) -> Coordinator {
        let appCoordinator = AppCoordinator(window: window, navigationController: navigationController)
        self.appCoordinator = appCoordinator
        return appCoordinator
    }
    
    func makeShapeCoordinator(_ router: RouterProtocol) -> Coordinator {
        return ShapesCoordinator(router)
    }
    
    func makeSimpleShapeCoordinator(_ router: RouterProtocol) -> Coordinator {
        return SimpleShapesCoordinator(router)
    }
    
    func makeCustomShapeCoordinator(_ router: RouterProtocol) -> Coordinator {
        return CustomShapesCoordinator(router)
    }
    
    func makeFeaturedShapeCoordinator(_ router: RouterProtocol) -> Coordinator {
        return ShapesCoordinator(router)
    }
}
