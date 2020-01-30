//
//  LoginInteractor.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 24/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation

protocol LoginInteractor {
    func loginOrRegister(withUserId userId: String,
                         andDisplayName username: String,
                         onSuccess: @escaping (() -> Void),
                         onError: @escaping ((String) -> Void))
}
