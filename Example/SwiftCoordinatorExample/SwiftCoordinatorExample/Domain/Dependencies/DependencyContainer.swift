//
//  DependencyContainer.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 03.09.2024.
//

import SwiftCoordinator
import Foundation

/// `DependencyContainer` is used for resolving dependencies.
///
/// It implements the Dependency Injection (DI) software design pattern, which is a part of Inversion of Control (IoC).
/// `DependencyContainer` helps the app by splitting it into loosely-coupled components, making testing and maintenance easier.
/// In `DependencyContainer`, components can be easily developed due to the substitution of protocol implementations.

final class DependencyContainer {
    static let shared = DependencyContainer()
    
    // MARK: - Singeltons
    var appCoordinator: Coordinator?
}
