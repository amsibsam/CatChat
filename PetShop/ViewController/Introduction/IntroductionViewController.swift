//
//  HomeViewController.swift
//  PetShop
//
//  Created by Rahardyan Bisma Setya Putra on 06/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import QiscusCore

class IntroductionViewController: ASViewController<IntroductionNode> {
    private let introductionNode: IntroductionNode
    private let viewModel: IntroductionViewModel
    
    init(viewModel: IntroductionViewModel) {
        self.viewModel = viewModel
        self.introductionNode = IntroductionNode(viewModel: self.viewModel)
        super.init(node: self.introductionNode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.onStartFinished = { isSuccess in
            if !isSuccess {
                print("login failed")
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
