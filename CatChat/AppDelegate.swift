//
//  AppDelegate.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 19/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import UIKit
import QiscusCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let appCoordinator = AppCoordinator(navigationMethod: self.window!)
        
        appCoordinator.start()
        
        return true
    }


}

