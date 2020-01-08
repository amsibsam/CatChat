//
//  ChatRoomViewModel.swift
//  PetShop
//
//  Created by Rahardyan Bisma Setya Putra on 08/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation

class ChatRoomViewModel {
    private let navigator: ChatRoomNavigator
    private let partnerUserId: String
    
    var onChatLoaded: (()->Void)? = nil
    
    init(navigator: ChatRoomNavigator, partnerUserId: String) {
        self.navigator = navigator
        self.partnerUserId = partnerUserId
    }
}
