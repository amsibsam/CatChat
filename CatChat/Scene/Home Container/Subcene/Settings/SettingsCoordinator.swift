//
//  SettingsCoordinator.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsNavigator {
    func openAppToValidate()
}

class SettingsCoordinator: Coordinator {
    typealias NavigationMethod = UINavigationController
    var navigationMethod: UINavigationController
    
    required init(navigationMethod: UINavigationController) {
        self.navigationMethod = navigationMethod
    }
    
    func start() {
        let viewModel = SettingsViewModel(navigator: self, interactor: SettingsInteractorImpl())
        let viewController = SettingsViewController(viewModel: viewModel)
        viewController.title = "Settings"
        self.navigationMethod.viewControllers = [viewController]
    }
}

extension SettingsCoordinator: SettingsNavigator {
    func openAppToValidate() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let window = appDelegate.window else {
            return
        }
        let appCoordinator = AppCoordinator(navigationMethod: window)
        appCoordinator.start()
    }
}
