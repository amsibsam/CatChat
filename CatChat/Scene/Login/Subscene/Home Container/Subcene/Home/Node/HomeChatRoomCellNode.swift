//
//  HomeChatRoomCellNode.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class HomeChatRoomCellNode: ASCellNode {
    private let viewModel: HomeChatRoomCellViewModel
    private let nameTextNode: ASTextNode = ASTextNode()
    private let lastCommentTextNode: ASTextNode = ASTextNode()
    
    init(viewModel: HomeChatRoomCellViewModel) {
        self.viewModel = viewModel
        super.init()
        self.automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stackLayout = ASStackLayoutSpec(direction: .vertical,
                                            spacing: 5,
                                            justifyContent: .center,
                                            alignItems: .start,
                                            children: [self.configuredNameTextNode(),
                                                       self.configuredLastCommentTextNode()])
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10), child: stackLayout)
    }
    
    // MARK: - Private Function -
    private func configuredNameTextNode() -> ASDisplayNode {
        let chatRoom = self.viewModel.chatRoom
        self.nameTextNode.placeholderEnabled = true
        self.nameTextNode.placeholderFadeDuration = 1
        self.nameTextNode.attributedText = NSAttributedString(string: chatRoom.name,
                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                           NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        self.nameTextNode.maximumNumberOfLines = 1
        self.nameTextNode.truncationMode = .byTruncatingTail
        self.nameTextNode.style.minWidth = ASDimensionMake(100)
        
        return self.nameTextNode
    }
    
    private func configuredLastCommentTextNode() -> ASLayoutSpec {
        let chatRoom = self.viewModel.chatRoom
        let lastComment = chatRoom.lastComment
        self.lastCommentTextNode.placeholderEnabled = true
        self.lastCommentTextNode.placeholderFadeDuration = 1
        self.lastCommentTextNode.attributedText = NSAttributedString(string: lastComment?.message ?? "",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray,
                                                                                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        self.lastCommentTextNode.style.minWidth = ASDimensionMake(140)
        
        let insetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0), child: self.lastCommentTextNode)
        
        return insetSpec
    }
}
