//
//  ChatInputNode.swift
//  PetShop
//
//  Created by Rahardyan Bisma Setya Putra on 08/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class ChatInputNode: ASDisplayNode {
    private let viewModel: ChatRoomViewModel
    
    init(viewModel: ChatRoomViewModel) {
        self.viewModel = viewModel
        super.init()
        self.automaticallyManagesSubnodes = true
    }
}
