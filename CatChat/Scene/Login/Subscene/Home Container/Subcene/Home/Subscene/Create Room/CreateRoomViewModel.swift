//
//  CreateRoomViewModel.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation

class CreateRoomViewModel {
    private let navigator: CreateRoomNavigator
    
    init(navigator: CreateRoomNavigator) {
        self.navigator = navigator
    }
    
    func cancelCreateRoom() {
        self.navigator.dismiss()
    }
    
    func crateRoomWith(partnerId: String) {
        self.navigator.dismissAndStartChatWith(partnerId: partnerId)
    }
}
