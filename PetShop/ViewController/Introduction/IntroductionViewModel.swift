//
//  IntroductionViewModel.swift
//  PetShop
//
//  Created by Rahardyan Bisma Setya Putra on 08/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import QiscusCore

class IntroductionViewModel {
    private let navigator: IntroductionNavigator
    var onStartFinished: ((_ isSuccess: Bool) -> Void)? = nil
    
    init(navigator: IntroductionNavigator) {
        self.navigator = navigator
    }
    func start(userId: String, completion: @escaping ((Bool) -> Void)) {
        QiscusCore.setUser(userId: userId, userKey: "pawsome", onSuccess: { [unowned self] (qiscusUser) in
            self.onStartFinished?(true)
            completion(true)
            self.navigator.openHome()
        }, onError: { (error) in
            self.onStartFinished?(false)
            completion(false)
        })
    }
    
}
