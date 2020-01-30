//
//  HomeNode.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 19/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class LoginNode: ASDisplayNode {
    private let viewModel: LoginViewModel
    private let iconNode = ASNetworkImageNode()
    private let titleNode = ASTextNode()
    private let campaignNode = TextWithIconNode()
    let userIdEditableText = ASEditableTextNode()
    let loginButton = ASButtonNode()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init()
        self.backgroundColor = .white
        self.loginButton.backgroundColor = .black
        automaticallyManagesSubnodes = true
    }
    
    private func configureContent() -> ASLayoutSpec {
        let contentStackSpec = ASStackLayoutSpec(direction: .vertical,
                                                 spacing: 0,
                                                 justifyContent: .center,
                                                 alignItems: .center,
                                                 children: [self.configuredIcon(),
                                                            self.configuredTitle(),
                                                            self.configuredCampaignNode(),
                                                            self.configuredUserId(),
                                                            self.configureNavigateButton()])
        
        return contentStackSpec
    }
    
    private func configureNavigateButton() -> ASDisplayNode {
        self.loginButton.setTitle("Start", with: .systemFont(ofSize: 14), with: .white, for: .normal)
        self.loginButton.setTitle("Start", with: .systemFont(ofSize: 14), with: .gray, for: .highlighted)
        self.loginButton.setTitle("Starting..", with: .systemFont(ofSize: 14), with: .white, for: .disabled)
        self.loginButton.cornerRadius = 6
        self.loginButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        self.loginButton.style.spacingBefore = 10
        self.loginButton.style.minWidth = ASDimensionMake(120)
        self.loginButton.style.minHeight = ASDimensionMake(40)
        self.loginButton.isUserInteractionEnabled = true
        
        return self.loginButton
    }
    
    private func configuredCampaignNode() -> ASDisplayNode {
        self.campaignNode.text = "Let's talk all about pawsome cat"
        self.campaignNode.imageUrl = "http://www.iconarchive.com/download/i107331/google/noto-emoji-animals-nature/22221-cat.ico"
        
        return self.campaignNode
    }
    
    private func configuredTitle() -> ASDisplayNode {
        self.titleNode.attributedText = NSAttributedString(string: "CatChat",
                                                           attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24)])
        self.titleNode.style.spacingBefore = 8
        self.titleNode.style.spacingAfter = 4
        
        return self.titleNode
    }
    
    private func configuredUserId() -> ASDisplayNode {
        self.userIdEditableText.attributedPlaceholderText = NSAttributedString(string: "User Id",
                                                                       attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor : UIColor.gray])
        self.userIdEditableText.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.userIdEditableText.borderColor = UIColor.gray.cgColor
        self.userIdEditableText.borderWidth = 2
        self.userIdEditableText.cornerRadius = 6
        self.userIdEditableText.style.spacingBefore = 10
        self.userIdEditableText.style.minWidth = ASDimensionMake(200)
        
        return self.userIdEditableText
    }
    
    private func configuredIcon() -> ASLayoutSpec {
        self.iconNode.url = URL(string: "https://cdn4.iconfinder.com/data/icons/black-cat-pattern/94/cat11-512.png")
        self.iconNode.placeholderEnabled = true
        self.iconNode.placeholderFadeDuration = 1
        self.iconNode.shouldCacheImage = false
        
        self.iconNode.contentMode = .scaleAspectFit
        
        let imageRatioSpec = ASRatioLayoutSpec(ratio: 2/3, child: self.iconNode)
        let insetImageSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30), child: imageRatioSpec)
        
        return insetImageSpec
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return self.configureContent()
    }
}
