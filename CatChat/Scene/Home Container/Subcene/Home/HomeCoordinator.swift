//
//  HomeCoordinator.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

protocol HomeNavigator {
    func openChatRoom(with userId: String)
    func openCreateRoom()
    func showFetchingLoading()
    func dismissFetchingLoading()
}

class HomeCoordinator: Coordinator {
    typealias NavigationMethod = UINavigationController
    var navigationMethod: UINavigationController
    
    private var tabController: UITabBarController? = nil
    
    required init(navigationMethod: NavigationMethod) {
        self.navigationMethod = navigationMethod
    }
    
    convenience init(navigationMethod: NavigationMethod, tabController: UITabBarController) {
        self.init(navigationMethod: navigationMethod)
        self.tabController = tabController
    }
    
    func start() {
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 40
        let viewModel = HomeViewModel(navigator: self, interactor: HomeInteractorImpl())
        let viewController = HomeViewController(viewModel: viewModel, tabBar: tabController?.tabBar)
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationMethod.viewControllers = [viewController]
    }
}

extension HomeCoordinator: HomeNavigator {
    func openChatRoom(with userId: String) {
        let chatRoomCoordinator = ChatRoomCoordinator(navigationMethod: self.navigationMethod)
        chatRoomCoordinator.start(partnerUserId: userId)
    }
    
    func openCreateRoom() {
        let createRoomCoordinator = CreateRoomCoordinator(navigationMethod: self.navigationMethod)
        if self.tabController?.selectedIndex == 0 {
            createRoomCoordinator.start { [unowned self] (partnerId) in
                self.openChatRoom(with: partnerId)
            }
        } else {
            self.tabController?.selectedIndex = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [unowned self] in
                createRoomCoordinator.start { [unowned self] (partnerId) in
                    self.openChatRoom(with: partnerId)
                }
            }
        }
    }
    
    func showFetchingLoading() {
        let loadingController = UIAlertController(title: "Load Room", message: "Please wait..", preferredStyle: .alert)
        self.navigationMethod.present(loadingController, animated: true, completion: nil)
    }
    
    func dismissFetchingLoading() {
        self.navigationMethod.dismiss(animated: true, completion: nil)
    }
}
