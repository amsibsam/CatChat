//
//  HomeTabCoordinator.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import UIKit
import AsyncDisplayKit

class HomeTabCoordinator: Coordinator {
    typealias NavigationMethod = UIWindow
    var navigationMethod: UIWindow
    
    private let tabBarController = UITabBarController()
    private let homeCoordinator: HomeCoordinator
    private let settingsCoordinator: SettingsCoordinator
    
    required init(navigationMethod: UIWindow) {
        self.navigationMethod = navigationMethod
        let homeNavigation = UINavigationController()
        homeNavigation.navigationBar.isTranslucent = false
        let settingNavigation = UINavigationController()
        settingNavigation.navigationBar.isTranslucent = false
        self.homeCoordinator = HomeCoordinator(navigationMethod: homeNavigation, tabController: self.tabBarController)
        self.settingsCoordinator = SettingsCoordinator(navigationMethod: settingNavigation)
    }
    
    func start() {
        configureTabBar()
        self.navigationMethod.rootViewController = self.tabBarController
        self.navigationMethod.makeKeyAndVisible()
    }
    
    // MARK: - Private Function -
    private func configureTabBar() {
        self.homeCoordinator.start()
        self.settingsCoordinator.start()
        
        self.homeCoordinator.navigationMethod.tabBarItem = UITabBarItem(title: "Home",
                                                                        image: #imageLiteral(resourceName: "incactive_home_tab"),
                                                                        selectedImage: #imageLiteral(resourceName: "active_home_tab"))
        self.settingsCoordinator.navigationMethod.tabBarItem = UITabBarItem(title: "Settings",
                                                                            image: #imageLiteral(resourceName: "inactive_setting_tab"),
                                                                            selectedImage: #imageLiteral(resourceName: "inactive_setting_tab"))
        
        self.tabBarController.viewControllers = [self.homeCoordinator.navigationMethod, self.settingsCoordinator.navigationMethod]
        self.tabBarController.tabBar.tintColor = .black
        self.tabBarController.selectedIndex = 0
        self.tabBarController.tabBar.isTranslucent = false
    }
    
}
