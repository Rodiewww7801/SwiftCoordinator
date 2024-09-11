# SwiftCoordinator

[...Stil in progress...] This is a Swift package with a implementation of the "Coordinator desing pattern". One Coordinator for both frameworks SwiftUI and UIKit.
Used UINavigationStack to manage navigation with converted SwiftUI views to UIHostingController. 

## Content
1. [**Why this code exist?**](https://github.com/Rodiewww7801/SwiftCoordinator?tab=readme-ov-file#why-this-code-exsist)
2. [**What is Coordinator?**](https://github.com/Rodiewww7801/SwiftCoordinator?tab=readme-ov-file#what-is-coordinator)
3. [**UML Diagram**](https://github.com/Rodiewww7801/SwiftCoordinator?tab=readme-ov-file#uml-diagram)
4. [**Example of usage**](https://github.com/Rodiewww7801/SwiftCoordinator?tab=readme-ov-file#example-of-usage)
5. [**Installation**](https://github.com/Rodiewww7801/SwiftCoordinator?tab=readme-ov-file#instalation)



## Why this code exsist?
[StackOverlow problem](https://stackoverflow.com/questions/61304700/swiftui-how-to-avoid-navigation-hardcoded-into-the-view) You can check how many problems would you has have with big application using Apple tools for SwiftUI navigations. Even using new SwiftUI `NavigationStack` you steal need use coordinator to reuse view with navigation logic + your code will has ugly generics.

I provide my approach of implementaion the pattern Сoordinator without "extra pattern solutions". Doesn't have complex logic. I use it in my iOS projects.

**Q: Who told you that we need Coordinator in SwiftUI?**

**A:** SwiftUI has its own navigation solutions that simplify navigation between views, but they are not always convenient for complex applications with multiple flows where navigation might need to change dynamically or be managed through a separate presentation layer. This is the essence of the Coordinator pattern – to separate the navigation logic and delegate this responsibility to a different abstraction.

**Q: I saw simplest way SwiftUI Coordinator without using your creepy-shitty code with UINavigationController and UIHostingController view parsing.**

**A:** I use UINavigationStack to take full advantage of UIKit navigation so u need to parse SwiftUI view to UIHostingController, but if you need to use the SwiftUI framework's navigation logic somewhere, you can still implement it within a SwiftUI view struct.

**Q: Why we need any UIKit crap in our SwiftUI?**

**A:** UIKit has many tools for which there are no direct support in SwiftUI, and you need to write your own representable class to make a UIKit class work with a SwiftUI struct. As example try to implement `AVFoundation` in SwiftUI.

**Q: So it support both SwiftUI and UIKit views?**

**A:** Yes, it does.

**Q: You just steal code from [SwiftUICoordinator](https://github.com/erikdrobne/SwiftUICoordinator).**

  - I don't like its approach to handle View-ViewModel-Coordinator actions. It's unjustified complexity of the coordinator's idea. This can be implemented more easily.
  - I dont like its architecture style with generics View structs. View don't need to dependce on generics to delegate Coordinator events. 
  - I dont like its how views should have a transition and which should not via `isEligible` method.
  - Its coud be done more easily easier and more obvious.
  - Its doesn't support both SwiftUI and UIKit.
  - I like Route idea and NavigationController transition handler.

**Q: It would be grate to see same for AppKit.**

**A:** If I will do AppKit app i do.

## What is Coordinator?

**Coordinator**: The Coordinator is responsible for controlling the navigation flow of the application. It manages which view controllers should be presented or pushed.

**Router**: The Router handles the details of navigation—such as pushing or presenting view controllers. The Router's job is to encapsulate navigation logic.

**Route**: The route helps coordinator to devide views on types that coordinator can navigate and set the transition between different types.

## UML Diagram 

![UMLDiagram drawio](https://github.com/user-attachments/assets/6803cd80-2d1c-4edd-86db-a5a52921014a)


## Example of usage
### Setup if you created SwiftUI app.
1. Set ``@UIApplicationDelegateAdaptor`` for delegate UIKit UIApplicationDelegate in a SwiftUI app. It creates an instance of `AppDelegate`.
```
@main
struct SwiftCoordinatorApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup { }
    }
}
```
2. Inside `AppDelegate` sets `SceneDelegate` as the delegate class for the scene, ensuring that `SceneDelegate` will manage the lifecycle and UI setup for this scene.
```
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
```
3. Inside `SceneDelegate` retrieves the window from the UIWindowScene object. Uses a factory object to create a `UINavigationController` instance. This is where the app's navigation stack starts.
```
final class SceneDelegate: NSObject, UIWindowSceneDelegate {
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let window = (scene as? UIWindowScene)?.windows.first else {
            return
        }
        
        let navigationController = navigationControllerFactory.makeNavigationController()
        let yourCoordinator = coordinatorFactory.makeYourCoordinator(window: window, navigationController: navigationController)
        yourCoordinator.start()
    }
}
```
4. Don't forget set widnow property inside yours first/main coordinator:
```
yourCoordinator.window.rootViewController = navigationController
yourCoordinator.window.makeKeyAndVisible()
```

### Example of usage

1. Create your `NavigationRoute` to enum views. If you want you can set transition for each route in `transitionType` property. 
```
enum CustomShapesRoute: NavigationRoute {
    case triangle
    case star
    case tower
    
    var transitionType: AnimatedTransitioning? {
        nil
    }
}
```
2. Create your view factory implementing `RouteViewFactoryProtocol`.
```
class CustomShapesViewFactory: RouteViewFactoryProtocol {
    @ViewBuilder
    func view(for route: CustomShapesRoute) -> some View {
        switch route {
        case .triangle:
            TriangleView()
        default:
            StarView()
        }
    }
}
```
3. Create your ``Coordinator`` and set `router` property.
```
class CustomShapeCoordinator: Coordinator {
    private var router: RouterProtocol
    private var factory = CustomShapesViewFactory()
    var childCoordinators: [Coordinator] = []
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    func start() {
        let view = factory.factory(for: .triangle)
        self.router.push(view, animated: true)
    }
}
```

### More detail example inside `Example` directory.

## Instalation
### Swift Package Manager
```
dependencies: [
    .package(url: "https://github.com/Rodiewww7801/SwiftCoordinator")
]
```


