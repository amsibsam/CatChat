//
//  ChatRoomMainNode.swift
//  PetShop
//
//  Created by Rahardyan Bisma Setya Putra on 08/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class ChatRoomMainNode: ASDisplayNode {
    private let chatTableNode: ASTableNode = ASTableNode(style: .plain)
    private let viewModel: ChatRoomViewModel
    
    init(viewModel: ChatRoomViewModel) {
        self.viewModel = viewModel
        super.init()
        self.backgroundColor = .white
        self.automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return self.configuredFinalLayoutSpec()
    }
    
    private func configuredFinalLayoutSpec() -> ASLayoutSpec {
        let verticalStackSpec = ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .center, alignItems: .center, children: [self.configuredChatTableNode()])
        
        return verticalStackSpec
    }
    
    private func configuredChatTableNode() -> ASDisplayNode {
        self.chatTableNode.delegate = self
        self.chatTableNode.dataSource = self
        self.chatTableNode.backgroundColor = .black
        self.chatTableNode.view.showsVerticalScrollIndicator = true
        self.chatTableNode.view.alwaysBounceVertical = false
        self.chatTableNode.style.flexBasis = ASDimensionMake("85%")
        
        return self.chatTableNode
    }
}

extension ChatRoomMainNode: ASTableDelegate, ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        return ASCellNode()
    }
}
