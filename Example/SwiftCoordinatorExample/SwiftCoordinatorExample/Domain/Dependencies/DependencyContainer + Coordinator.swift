//
//  DependencyContainer + Coordinator.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 05.09.2024.
//

import Foundation

extension DependencyContainer {    
    var coordinatorFactory: CoordinatorFactoryProtocol {
        return CoordinatorFactory()
    }
}
