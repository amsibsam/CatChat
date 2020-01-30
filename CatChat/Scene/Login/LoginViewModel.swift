//
//  IntroductionViewModel.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 19/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation

class LoginViewModel {
    private let navigator: LoginNavigator
    private let interactor: LoginInteractor
    var onLoginProcessFinished: ((_ isSuccess: Bool) -> Void)? = nil
    
    init(navigator: LoginNavigator, interactor: LoginInteractor) {
        self.navigator = navigator
        self.interactor = interactor
    }
    
    func loginWith(userId: String) {
        self.interactor.loginOrRegister(withUserId: userId, andDisplayName: userId, onSuccess: {
            self.onLoginProcessFinished?(true)
            self.navigator.openAppToValidate()
        }, onError: { (error) in
            self.onLoginProcessFinished?(false)
        })
    }
    
}
