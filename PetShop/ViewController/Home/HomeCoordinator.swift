//
//  HomeCoordinator.swift
//  PetShop
//
//  Created by Rahardyan Bisma Setya Putra on 08/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

protocol HomeNavigator {
    func openChatRoom(with userId: String)
}

class HomeCoordinator: BaseCoordniatorProtocol {
    typealias NavigationMethod = UIWindow
    var navigationMethod: UIWindow
    
    required init(navigationMethod: UIWindow) {
        self.navigationMethod = navigationMethod
    }
    
    func start() {
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 40
        let viewModel = HomeViewModel(navigator: self)
        let viewController = HomeViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        self.navigationMethod.rootViewController = navigationController
        self.navigationMethod.makeKeyAndVisible()
    }
}

extension HomeCoordinator: HomeNavigator {
    func openChatRoom(with userId: String) {
        guard let navController = self.navigationMethod.rootViewController as? UINavigationController else { return }
        let chatRoomCoordinator = ChatRoomCoordinator(navigationMethod: navController)
        chatRoomCoordinator.start(partnerUserId: userId)
    }
}
