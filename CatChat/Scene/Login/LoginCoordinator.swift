//
//  IntroductionCoordinator.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 19/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

protocol LoginNavigator {
    func openAppToValidate()
}

class LoginCoordinator: Coordinator {
    typealias NavigationMethod = UIWindow
    var navigationMethod: UIWindow
    
    required init(navigationMethod: UIWindow) {
        self.navigationMethod = navigationMethod
    }
    
    func start() {
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 40
        let viewModel = LoginViewModel(navigator: self, interactor: LoginInteractorImpl())
        let viewController = LoginViewController(viewModel: viewModel)
        self.navigationMethod.rootViewController = viewController
    }
    
}

extension LoginCoordinator: LoginNavigator {
    func openAppToValidate() {
        let appCoordinator = AppCoordinator(navigationMethod: self.navigationMethod)
        appCoordinator.start()
    }
}


