//
//  AppDelegate.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 19/01/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: MainCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let navController = SwipeBackNavigationController()
        navController.setNavigationBarHidden(true, animated: true)
        coordinator = MainCoordinator(navigationController: navController)
        coordinator?.start()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }
}

