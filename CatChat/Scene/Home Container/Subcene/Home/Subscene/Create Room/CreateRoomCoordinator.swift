//
//  CreateRoomCoordinator.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

protocol CreateRoomNavigator {
    func dismissAndStartChatWith(partnerId: String)
    func dismiss()
}

class CreateRoomCoordinator: Coordinator {
    
    typealias NavigationMethod = UINavigationController
    var navigationMethod: UINavigationController
    
    private var onResult: ((String) -> Void)? = nil
    
    required init(navigationMethod: UINavigationController) {
        self.navigationMethod = navigationMethod
    }
    
    func start() {
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 40
        let viewModel = CreateRoomViewModel(navigator: self)
        let viewController = CreateRoomViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        
        self.navigationMethod.present(viewController, animated: true, completion: nil)
    }
    
    func start(withResult result: @escaping ((String) -> Void)) {
        self.onResult = result
        self.start()
    }
}

extension CreateRoomCoordinator: CreateRoomNavigator {
    func dismissAndStartChatWith(partnerId: String) {
        self.navigationMethod.dismiss(animated: true) { [unowned self] in
            self.onResult?(partnerId)
        }
    }
    
    func dismiss() {
        self.navigationMethod.dismiss(animated: true, completion: nil)
    }
}
