//
//  HomeViewController.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 19/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import QiscusCore

class LoginViewController: ASViewController<LoginNode> {
    private let loginNode: LoginNode
    private let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        self.loginNode = LoginNode(viewModel: self.viewModel)
        super.init(node: self.loginNode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        
        self.loginNode.loginButton.didTap = { [unowned self] in
            self.loginNode.loginButton.isEnabled = false
            self.loginNode.loginButton.view.backgroundColor = .gray
            
            let userId = self.loginNode.userIdEditableText.attributedText?.string ?? ""
            self.viewModel.loginWith(userId: userId)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindViewModel() {
        self.viewModel.onLoginProcessFinished = { [weak self] isSuccess in
            guard let `self` = self else {
                return
            }
            
            if !isSuccess {
                self.loginNode.loginButton.setTitle("Login Failed", with: UIFont.systemFont(ofSize: 12), with: .white, for: .disabled)
                self.loginNode.loginButton.layoutIfNeeded()
                self.loginNode.loginButton.backgroundColor = .red
            }
            
            DispatchQueue.main.asyncAfter(deadline: isSuccess ? .now() : .now() + 2) {
                self.loginNode.loginButton.setTitle("Starting..", with: .systemFont(ofSize: 14), with: .white, for: .disabled)
                self.loginNode.loginButton.isEnabled = true
                self.loginNode.loginButton.backgroundColor = .black
            }
            print("login status \(isSuccess)")
        }
    }
}
