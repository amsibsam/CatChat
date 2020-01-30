//
//  ChatRoomCoordinator.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

protocol ChatRoomNavigator {
    
}

class ChatRoomCoordinator: Coordinator {
    typealias NavigationMethod = UINavigationController
    var navigationMethod: UINavigationController
    private var partnerUserId: String = ""
    
    required init(navigationMethod: UINavigationController) {
        self.navigationMethod = navigationMethod
    }
    
    func start() {
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 4
        let viewModel = ChatRoomViewModel(navigator: self, interactor: ChatRoomInteractorImpl(), partnerUserId: self.partnerUserId )
        let viewController = ChatRoomViewController(viewModel: viewModel)
        viewController.hidesBottomBarWhenPushed = true
        
        self.navigationMethod.pushViewController(viewController, animated: true)
    }
    
    func start(partnerUserId: String) {
        self.partnerUserId = partnerUserId
        self.start()
    }
}

extension ChatRoomCoordinator: ChatRoomNavigator {
    
}
