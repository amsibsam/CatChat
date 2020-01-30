//
//  SettingsInteractor.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation

protocol SettingsInteractor {
    func logout(onComplete: @escaping ((Bool) -> Void))
}
