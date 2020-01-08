//
//  HomeNode.swift
//  PetShop
//
//  Created by Rahardyan Bisma Setya Putra on 06/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class IntroductionNode: ASDisplayNode {
    private let viewModel: IntroductionViewModel
    private let iconNode = ASNetworkImageNode()
    private let titleNode = ASTextNode()
    private let campaignNode = TextWithIconNode()
    private let userIdNode = ASEditableTextNode()
    private let navigateBtn = ASButtonNode()
    
    init(viewModel: IntroductionViewModel) {
        self.viewModel = viewModel
        super.init()
        self.backgroundColor = .white
        self.navigateBtn.backgroundColor = .black
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
        self.navigateBtn.setTitle("Start", with: .systemFont(ofSize: 14), with: .white, for: .normal)
        self.navigateBtn.setTitle("Start", with: .systemFont(ofSize: 14), with: .gray, for: .highlighted)
        self.navigateBtn.setTitle("Starting..", with: .systemFont(ofSize: 14), with: .white, for: .disabled)
        self.navigateBtn.cornerRadius = 6
        self.navigateBtn.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        self.navigateBtn.style.spacingBefore = 10
        self.navigateBtn.style.minWidth = ASDimensionMake(120)
        self.navigateBtn.isUserInteractionEnabled = true
        self.navigateBtn.didTap = { [unowned self] in
            self.navigateBtn.isEnabled = false
            self.navigateBtn.view.backgroundColor = .gray
            self.viewModel.start(userId: self.userIdNode.attributedText?.string ?? "", completion: { [unowned self] isSuccess in
                self.navigateBtn.isEnabled = true
                self.navigateBtn.backgroundColor = .black
            })
        }
        
        return self.navigateBtn
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
        self.userIdNode.attributedPlaceholderText = NSAttributedString(string: "User Id",
                                                                       attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor : UIColor.gray])
        self.userIdNode.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.userIdNode.borderColor = UIColor.gray.cgColor
        self.userIdNode.borderWidth = 2
        self.userIdNode.cornerRadius = 6
        self.userIdNode.style.spacingBefore = 10
        self.userIdNode.style.minWidth = ASDimensionMake(200)
        
        return self.userIdNode
    }
    
    private func configuredIcon() -> ASLayoutSpec {
        self.iconNode.url = URL(string: "https://cdn4.iconfinder.com/data/icons/black-cat-pattern/94/cat11-512.png")
        
        self.iconNode.contentMode = .scaleAspectFit
        
        let imageRatioSpec = ASRatioLayoutSpec(ratio: 2/3, child: self.iconNode)
        let insetImageSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30), child: imageRatioSpec)
        
        return insetImageSpec
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return self.configureContent()
    }
}
