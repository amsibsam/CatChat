//
//  SettingsViewController.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class SettingsViewController: ASViewController<ASDisplayNode> {
    
    private let viewModel: SettingsViewModel
    private let settingsMainNode: SettingsMainNode
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        self.settingsMainNode = SettingsMainNode(viewModel: viewModel)
        super.init(node: self.settingsMainNode)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
        self.settingsMainNode.logoutButtonNode.didTap = { [unowned self] in
            self.settingsMainNode.logoutButtonNode.isEnabled = false
            self.viewModel.logout()
        }
    }
    
    private func bindViewModel() {
        self.viewModel.onLogoutComplete = { [weak self] isSuccess in
            if !isSuccess {
                self?.settingsMainNode.logoutButtonNode.isEnabled = true
            }
        }
    }
}
