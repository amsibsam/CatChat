//
//  SettingsMainNode.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class SettingsMainNode: ASDisplayNode {
    private let viewModel: SettingsViewModel
    let logoutButtonNode: ASButtonNode = ASButtonNode()
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init()
        self.automaticallyManagesSubnodes = true
        self.backgroundColor = .white
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASWrapperLayoutSpec(layoutElement: self.configuredLogoutButtonNode())
    }
    
    private func configuredLogoutButtonNode() -> ASDisplayNode {
        self.logoutButtonNode.setTitle("Logout", with: .systemFont(ofSize: 14), with: .red, for: .normal)
        self.logoutButtonNode.setTitle("Logout", with: .systemFont(ofSize: 14), with: .gray, for: .highlighted)
        self.logoutButtonNode.setTitle("Please wait..", with: .systemFont(ofSize: 14), with: .gray, for: .disabled)
        self.logoutButtonNode.isUserInteractionEnabled = true
        
        return self.logoutButtonNode
    }
}
