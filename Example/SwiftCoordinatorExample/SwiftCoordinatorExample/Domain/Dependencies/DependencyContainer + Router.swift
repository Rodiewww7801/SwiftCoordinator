//
//  DependencyContainer + Router.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 05.09.2024.
//

import Foundation

extension DependencyContainer {
    var routerFactory: RouterFactoryProtocol {
        return RouterFactory()
    }
}
