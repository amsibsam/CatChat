//
//  ChatRoomCoordinator.swift
//  PetShop
//
//  Created by Rahardyan Bisma Setya Putra on 08/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import UIKit

protocol ChatRoomNavigator {
    
}

class ChatRoomCoordinator: BaseCoordniatorProtocol {
    typealias NavigationMethod = UINavigationController
    var navigationMethod: UINavigationController
    private var partnerUserId: String = ""
    
    required init(navigationMethod: UINavigationController) {
        self.navigationMethod = navigationMethod
    }
    
    func start() {
        let viewModel = ChatRoomViewModel(navigator: self, partnerUserId: self.partnerUserId )
        let viewController = ChatRoomViewConroller(viewModel: viewModel)
        
        self.navigationMethod.pushViewController(viewController, animated: true)
    }
    
    func start(partnerUserId: String) {
        self.partnerUserId = partnerUserId
        self.start()
    }
}

extension ChatRoomCoordinator: ChatRoomNavigator {
    
}
