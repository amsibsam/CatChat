//
//  HomeViewController.swift
//  PetShop
//
//  Created by Rahardyan Bisma Setya Putra on 07/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class HomeViewController: ASViewController<ASDisplayNode> {
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(node: HomeNode(viewModel: self.viewModel))
        self.view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("not being overrided")
    }
}
