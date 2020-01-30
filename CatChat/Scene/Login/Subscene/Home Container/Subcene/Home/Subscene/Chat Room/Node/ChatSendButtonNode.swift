//
//  ChatSendButtonNode.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class ChatSendButtonNode: ASButtonNode {
    override init() {
        super.init()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.setImage(#imageLiteral(resourceName: "icon_send"), for: .normal)
        self.contentMode = .scaleAspectFit
        self.style.preferredSize = CGSize(width: 50, height: 50)
        self.cornerRadius = 25
    }
}
