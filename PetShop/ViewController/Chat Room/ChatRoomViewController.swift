//
//  ChatRoomViewController.swift
//  PetShop
//
//  Created by Rahardyan Bisma Setya Putra on 08/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class ChatRoomViewConroller: ASViewController<ASDisplayNode> {
    private let viewModel: ChatRoomViewModel
    
    init(viewModel: ChatRoomViewModel) {
        self.viewModel = viewModel
        // TODO: update this node
        super.init(node: ChatRoomMainNode(viewModel: self.viewModel))
        self.view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
