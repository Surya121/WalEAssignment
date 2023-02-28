//
//  AppDelegate.swift
//  WalEAssignment
//
//  Created by Surya Kant on 28/02/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let coordinator = HomeCoordinator()
        window?.rootViewController = coordinator.generateAPODScreen()
        window?.makeKeyAndVisible()
        return true
    }

}

