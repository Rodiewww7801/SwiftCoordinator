//
//  CoordinatorFactoryProtocol.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 05.09.2024.
//

import SwiftCoordinator
import Foundation
import UIKit

protocol CoordinatorFactoryProtocol {
    var appCoordinator: Coordinator? { get }
    func makeAppCoordinator(window: UIWindow, navigationController: UINavigationController) -> Coordinator
    func makeShapeCoordinator(_ router: RouterProtocol) -> Coordinator
    func makeSimpleShapeCoordinator(_ router: RouterProtocol) -> Coordinator
    func makeCustomShapeCoordinator(_ router: RouterProtocol) -> Coordinator
    func makeFeaturedShapeCoordinator(_ router: RouterProtocol) -> Coordinator
}
