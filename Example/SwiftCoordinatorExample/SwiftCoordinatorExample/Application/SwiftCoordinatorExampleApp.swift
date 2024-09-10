//
//  SwiftCoordinatorExampleApp.swift
//  SwiftCoordinatorExample
//
//  Created by Rodion Hladchenko on 10.09.2024.
//

import SwiftUI

internal var dependency = DependencyContainer.shared

@main
struct SwiftCoordinatorApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup { }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
}

final class SceneDelegate: NSObject, UIWindowSceneDelegate {
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let window = (scene as? UIWindowScene)?.windows.first else {
            return
        }
        
        let navigationController = dependency.navigationControllerFactory.makeNavigationController()
        let appCoordinator = dependency.coordinatorFactory.makeAppCoordinator(window: window, navigationController: navigationController)
        dependency.appCoordinator = appCoordinator
        appCoordinator.start()
    }
}
