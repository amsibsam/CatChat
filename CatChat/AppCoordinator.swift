//
//  AppCoordinator.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 19/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import UIKit
import QiscusCore
import IQKeyboardManagerSwift

protocol AppCoordinatorNavigator {
    func showIntroduction()
    func showHome()
}

class AppCoordinator: Coordinator {
    typealias NavigationMethod = UIWindow
    var navigationMethod: NavigationMethod
    
    required init(navigationMethod: NavigationMethod) {
        self.navigationMethod = navigationMethod
    }
    
    func start() {
        // setup root viewController state
        self.setupRootState()
        // setup Qiscus
        self.setupQiscus()
        // setup IQKeyboard
        self.setupIQKeyboard()
    }
    
    private func setupRootState() {
//        self.navigationMethod.rootViewController = TestViewController()
        if QiscusCore.hasSetupUser() {
            self.showHome()
        } else {
            self.showIntroduction()
        }
    }
    
    private func setupQiscus() {
        QiscusCore.setup(AppID: "petchat-qxydfgbb3z2k0")
    }
    
    private func setupIQKeyboard() {
        IQKeyboardManager.shared.enable = true
    }
}

extension AppCoordinator: AppCoordinatorNavigator {
    func showHome() {
        let homeTabCoordinator = HomeTabCoordinator(navigationMethod: self.navigationMethod)
        homeTabCoordinator.start()
    }
    
    func showIntroduction() {
        let loginCoordinator = LoginCoordinator(navigationMethod: self.navigationMethod)
        loginCoordinator.start()
    }
}
