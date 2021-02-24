//
//  AppDelegate.swift
//  PokeApp
//
//  Created by Intellisys on 23/2/21.
//

import UIKit
import Firebase
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var currentView: UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = UserApp.shared
        UINavigationBar.appearance().tintColor = .mainYellow
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.mainYellow]
        if #available(iOS 13.0, *) {
            return true
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = UserApp.shared.firebaseUser == nil ? LoginWireFrame.createModule() : UINavigationController(rootViewController: HomeWireFrame.createModule())
            window?.makeKeyAndVisible()
        }
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any])
      -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    func displayAlert(with error: Error) {
        
        if let view = currentView as? BaseViewController {
            view.presentAlert(with: "Error", message: error.localizedDescription, actions: [UIAlertAction(title: "Ok", style: .default, handler: nil)], completion: nil)
        }
    }
    
    func getWindow() -> UIWindow? {
            if #available(iOS 13, *) {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                      let delegate = windowScene.delegate as? SceneDelegate, let window = delegate.window else { return nil }
                return window
            }
            guard let delegate = UIApplication.shared.delegate as? AppDelegate, let window = delegate.window else { return nil }
            return window
            
        }
    
    func changeRootController(by controller: UIViewController) {
        let rootController = controller
        if let window = getWindow() {
            window.rootViewController = rootController
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            let duration: TimeInterval = 0.5
            UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)
        }
    }
}
