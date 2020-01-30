//
//  ChatInputContainerNode.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class ChatInputContainerNode: ASDisplayNode {
    override init() {
        super.init()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .darkGray
    }
}
