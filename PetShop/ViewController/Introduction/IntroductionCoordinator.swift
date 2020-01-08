//
//  IntroductionCoordinator.swift
//  PetShop
//
//  Created by Rahardyan Bisma Setya Putra on 08/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

protocol IntroductionNavigator {
    func openHome()
}

class IntroductionCoordinator: BaseCoordniatorProtocol {
    typealias NavigationMethod = UIWindow
    var navigationMethod: UIWindow
    
    required init(navigationMethod: UIWindow) {
        self.navigationMethod = navigationMethod
    }
    
    func start() {
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 40
        let viewModel = IntroductionViewModel(navigator: self)
        let viewController = IntroductionViewController(viewModel: viewModel)
        self.navigationMethod.rootViewController = viewController
    }
    
}

extension IntroductionCoordinator: IntroductionNavigator {
    func openHome() {
        let homeCoordinator = HomeCoordinator(navigationMethod: self.navigationMethod)
        homeCoordinator.start()
    }
}


