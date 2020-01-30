//
//  SettingsViewModel.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import QiscusCore

class SettingsViewModel {
    private let navigator: SettingsNavigator
    private let interactor: SettingsInteractor
    
    var onLogoutComplete: ((Bool) -> Void)? = nil
    
    init(navigator: SettingsNavigator, interactor: SettingsInteractor) {
        self.navigator = navigator
        self.interactor = interactor
    }
    
    func logout() {
        interactor.logout { [weak self] (isSuccess) in
            self?.onLogoutComplete?(isSuccess)
            if isSuccess {
                self?.navigator.openAppToValidate()
            }
        }
    }
}
