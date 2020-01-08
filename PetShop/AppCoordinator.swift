//
//  AppCoordinator.swift
//  PetShop
//
//  Created by Rahardyan Bisma Setya Putra on 08/01/20.
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

class AppCoordinator: BaseCoordniatorProtocol {
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
        let homeCoordinator = HomeCoordinator(navigationMethod: self.navigationMethod)
        homeCoordinator.start()
    }
    
    func showIntroduction() {
        let introductionCoordinator = IntroductionCoordinator(navigationMethod: self.navigationMethod)
        introductionCoordinator.start()
    }
}
