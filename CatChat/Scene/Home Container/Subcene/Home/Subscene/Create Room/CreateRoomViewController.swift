//
//  CreateRoomViewController.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class CreateRoomViewController: ASViewController<ASDisplayNode> {
    private let viewModel: CreateRoomViewModel
    
    init(viewModel: CreateRoomViewModel) {
        self.viewModel = viewModel
        super.init(node: CreateRoomNode(viewModel: viewModel))
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not overrided")
    }
}
