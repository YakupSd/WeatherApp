//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Yakup Suda on 22.03.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = HomeViewController() //ilk açıldığında nereyi gösterecek
        return true
    }

    // MARK: UISceneSession Lifecycle



}

