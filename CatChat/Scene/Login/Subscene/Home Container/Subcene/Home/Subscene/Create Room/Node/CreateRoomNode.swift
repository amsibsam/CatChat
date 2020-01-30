//
//  CreateRoomNode.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class CreateRoomNode: ASDisplayNode {
    private let viewModel: CreateRoomViewModel
    private let userIdEditableNode: ASEditableTextNode = ASEditableTextNode()
    private let cancelButtonNode: ASButtonNode = ASButtonNode()
    private let startButtonNode: ASButtonNode = ASButtonNode()
    private let chatImageNode: ASNetworkImageNode = ASNetworkImageNode()
    
    init(viewModel: CreateRoomViewModel) {
        self.viewModel = viewModel
        super.init()
        self.automaticallyManagesSubnodes = true
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stackSpec = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 10,
                                          justifyContent: .center,
                                          alignItems: .center,
                                          children: [self.configuredChatImageNode(),
                                                     self.configuredUserIdEditableNode(),
                                                     self.configuredStartButtonNode()])
        let insetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10,
                                                               left: 10,
                                                               bottom: 10,
                                                               right: 10),
                                          child: stackSpec)
        
        let overlaySpec = ASOverlayLayoutSpec(child: self.configuredBackgroundNode(), overlay: insetSpec)
        let cornerSpec = ASCornerLayoutSpec(child: overlaySpec,
                                            corner: self.configuredCancelButton(),
                                            location: .topLeft)
        cornerSpec.offset = CGPoint(x: 3, y: 0)
        
        let insetOverlayLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: UIScreen.main.bounds.height / 4,
                                                                        left: UIScreen.main.bounds.width / 7,
                                                                        bottom: UIScreen.main.bounds.height / 4,
                                                                        right: UIScreen.main.bounds.width / 7),
                                                   child: cornerSpec)
        
        return insetOverlayLayout
    }
    
    // MARK: - Private Function -
    private func configuredUserIdEditableNode() -> ASDisplayNode {
        self.userIdEditableNode.attributedPlaceholderText = NSAttributedString(string: "Partner User Id",
                                                                               attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),
                                                                                            NSAttributedString.Key.foregroundColor : UIColor.gray])
        self.userIdEditableNode.backgroundColor = .white
        self.userIdEditableNode.cornerRadius = 6
        self.userIdEditableNode.textContainerInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        self.userIdEditableNode.borderWidth = 2
        self.userIdEditableNode.borderColor = UIColor.gray.cgColor
        self.userIdEditableNode.style.width = ASDimensionMake(150)
        self.userIdEditableNode.clipsToBounds = true
        
        return self.userIdEditableNode
    }
    
    private func configuredChatImageNode() -> ASDisplayNode {
        self.chatImageNode.placeholderEnabled = true
        self.chatImageNode.placeholderFadeDuration = 0.5
        self.chatImageNode.url = URL(string: "https://www.vippng.com/png/detail/47-476751_speech-bubble-icon-png-live-chat-icon-png.png")
        self.chatImageNode.contentMode = .scaleAspectFit
        self.chatImageNode.style.preferredSize = CGSize(width: 150, height: 150)
        self.chatImageNode.style.spacingAfter = 0
        
        return self.chatImageNode
    }
    
    private func configuredBackgroundNode() -> ASDisplayNode {
        let backgroundNode = ASDisplayNode()
        backgroundNode.cornerRadius = 6
        backgroundNode.clipsToBounds = true
        backgroundNode.backgroundColor = .white
        
        return backgroundNode
    }
    
    private func configuredCancelButton() -> ASLayoutSpec {
        self.cancelButtonNode.setImage(#imageLiteral(resourceName: "close_button_normal"), for: .normal)
        self.cancelButtonNode.setImage(#imageLiteral(resourceName: "close_button_highlighted"), for: .highlighted)
        self.cancelButtonNode.style.preferredSize = CGSize(width: 10, height: 10)
        self.cancelButtonNode.style.maxWidth = ASDimensionMake(60)
        self.cancelButtonNode.style.maxHeight = ASDimensionMake(60)
        self.cancelButtonNode.style.minWidth = ASDimensionMake(60)
        self.cancelButtonNode.style.minHeight = ASDimensionMake(60)
        self.cancelButtonNode.style.flexGrow = 0
        self.cancelButtonNode.cornerRadius = 30
        self.cancelButtonNode.didTap = { [unowned self] in
            self.viewModel.cancelCreateRoom()
        }
        
        let bottomTopInset = UIScreen.main.isIphoneSEKind ? UIScreen.main.bounds.height / 5 : UIScreen.main.bounds.height / 4.6
        let leftRightInset = UIScreen.main.isIphoneSEKind ? UIScreen.main.bounds.width / 3.8 : UIScreen.main.bounds.width / 3.5
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: bottomTopInset, left: leftRightInset, bottom: bottomTopInset, right:  leftRightInset), child: self.cancelButtonNode)
    }
    
    private func configuredStartButtonNode() -> ASDisplayNode {
        self.startButtonNode.setTitle("Start Chat", with: UIFont.systemFont(ofSize: 12), with: .white, for: .normal)
        self.startButtonNode.setTitle("Start Chat", with: UIFont.systemFont(ofSize: 12), with: .gray, for: .highlighted)
        self.startButtonNode.backgroundColor = .black
        self.startButtonNode.clipsToBounds = true
        self.startButtonNode.cornerRadius = 6
        self.startButtonNode.borderColor = UIColor.black.cgColor
        self.startButtonNode.borderWidth = 2
        self.startButtonNode.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        self.startButtonNode.didTap = { [unowned self] in
            guard let partnerId = self.userIdEditableNode.attributedText?.string else {
                return
            }
            
            self.viewModel.crateRoomWith(partnerId: partnerId)
        }
        
        return self.startButtonNode
    }
    
}
