//
//  HomeChatRoomCellViewModel.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import QiscusCore

class HomeChatRoomCellViewModel {
    
    private let navigator: HomeNavigator
    var chatRoom: RoomModel
    
    init(navigator: HomeNavigator, chatRoom: RoomModel) {
        self.navigator = navigator
        self.chatRoom = chatRoom
    }
}
