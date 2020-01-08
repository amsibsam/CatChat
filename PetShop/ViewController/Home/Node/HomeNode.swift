//
//  HomeNode.swift
//  PetShop
//
//  Created by Rahardyan Bisma Setya Putra on 07/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class HomeNode: ASDisplayNode {
    private let noChatImageNode = ASNetworkImageNode()
    private let noChatTextNode = ASTextNode()
    private let chatInstructionTextNode = ASTextNode()
    private let userIdEditTextNode = ASEditableTextNode()
    private let startChatButtonNode = ASButtonNode()
    
    var onStartChatDidTap: (() -> Void)?
    
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.backgroundColor = .white
        self.startChatButtonNode.backgroundColor = .black
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return self.configuredContent()
    }
    
    private func configuredContent() -> ASLayoutSpec {
        let verticalStackSpec = ASStackLayoutSpec(direction: .vertical,
                                                  spacing: 4,
                                                  justifyContent: .center,
                                                  alignItems: .center,
                                                  children: [self.configuredNoChatImageNode(),
                                                             self.configuredNoChatTextNode(),
                                                             self.configuredInstructionTextNode(),
                                                             self.configuredUserIdEditableTextNode(),
                                                             self.configuredStartChatButtonNode()])
        
        return verticalStackSpec
    }
    
    private func configuredNoChatImageNode() -> ASDisplayNode {
        self.noChatImageNode.placeholderEnabled = true
        self.noChatImageNode.url = URL(string: "http://cdn.onlinewebfonts.com/svg/img_399648.png")
        self.noChatImageNode.contentMode = .scaleAspectFit
        self.noChatImageNode.style.preferredSize = CGSize(width: 200, height: 200)
        self.noChatImageNode.style.spacingAfter = 15
        
        return noChatImageNode
    }
    
    private func configuredNoChatTextNode() -> ASDisplayNode {
        self.noChatTextNode.attributedText = NSAttributedString(string: "You haven't chat to anyone yet", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
        
        return self.noChatTextNode
    }
    
    private func configuredInstructionTextNode() -> ASDisplayNode {
        self.chatInstructionTextNode.attributedText = NSAttributedString(string: "Let's start chat with someone", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor : UIColor.gray])
        
        return self.chatInstructionTextNode
    }
    
    private func configuredUserIdEditableTextNode() -> ASDisplayNode {
        self.userIdEditTextNode.attributedPlaceholderText = NSAttributedString(string: "User Id", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor : UIColor.gray])
        self.userIdEditTextNode.borderWidth = 2
        self.userIdEditTextNode.borderColor = UIColor.gray.cgColor
        self.userIdEditTextNode.cornerRadius = 6
        self.userIdEditTextNode.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.userIdEditTextNode.style.minWidth = ASDimensionMake(200)
        self.userIdEditTextNode.style.spacingBefore = 10
        
        return self.userIdEditTextNode
    }
    
    private func configuredStartChatButtonNode() -> ASDisplayNode {
        self.startChatButtonNode.isUserInteractionEnabled = true
        self.startChatButtonNode.setTitle("Start Chat", with: .systemFont(ofSize: 12), with: .white, for: .normal)
        self.startChatButtonNode.setTitle("Start Chat", with: .systemFont(ofSize: 12), with: .gray, for: .highlighted)
        self.startChatButtonNode.setTitle("Start Chat", with: .systemFont(ofSize: 12), with: .gray, for: .disabled)
        self.startChatButtonNode.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        self.startChatButtonNode.style.minWidth = ASDimensionMake(200)
        self.startChatButtonNode.style.spacingBefore = 6
        self.startChatButtonNode.cornerRadius = 6
        self.startChatButtonNode.didTap = { [weak self] in
            self?.onStartChatDidTap?()
        }
        
        return self.startChatButtonNode
    }
}
