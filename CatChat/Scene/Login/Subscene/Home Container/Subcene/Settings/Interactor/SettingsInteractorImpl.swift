//
//  SettingsInteractorImpl.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import QiscusCore

class SettingsInteractorImpl: SettingsInteractor {
    
    func logout(onComplete: @escaping ((Bool) -> Void)) {
        QiscusCore.clearUser { (error) in
            guard let _ = error else {
                onComplete(true)
                return
            }
            
            onComplete(false)
        }
    }
}
