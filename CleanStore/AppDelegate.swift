//
//  AppDelegate.swift
//  CleanStore
//
//  Created by Vladimir Fibe on 06.09.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = CreateOrderViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

