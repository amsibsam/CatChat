//
//  HomeViewController.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class HomeViewController: ASViewController<ASDisplayNode> {
    private let viewModel: HomeViewModel
    private let homeWithChatNode: ASDisplayNode
    private let startChatButton: ASButtonNode = ASButtonNode()
    private let tabBar: UITabBar?
    
    init(viewModel: HomeViewModel, tabBar: UITabBar?) {
        self.viewModel = viewModel
        self.homeWithChatNode = HomeWithChatNode(viewModel: self.viewModel)
        self.tabBar = tabBar
        
        super.init(node: self.homeWithChatNode)
        self.view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("not being overrided")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.bindViewModel()
        self.viewModel.listenRoomEvent(isNeedToListen: true)
        self.viewModel.loadRooms()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        self.viewModel.listenRoomEvent(isNeedToListen: false)
    }
    
    // MARK: - Private Function -
    private func configureNewChatButton() {
        self.startChatButton.removeFromSupernode()
        self.startChatButton.frame = CGRect(x: 0, y: 0, width: 65, height: (self.tabBar?.frame.height ?? 0) - 10)
        self.startChatButton.view.center = CGPoint(x: (self.tabBar?.frame.width ?? 0 ) / 2,
                                y: (self.tabBar?.frame.height ?? 0 ) / 2.2)
        self.startChatButton.setImage(#imageLiteral(resourceName: "new_chat"), for: .normal)
        self.startChatButton.didTap = { [unowned self] in
            self.viewModel.createChat()
        }
        
        self.tabBar?.addSubview(self.startChatButton.view)
    }
    
    private func bindViewModel() {
        self.viewModel.onNeedReconfigTabBar = { [weak self] isNeedShowCreateChat in
            if isNeedShowCreateChat {
                self?.configureNewChatButton()
            } else {
                self?.startChatButton.view.removeFromSuperview()
            }
        }
    }

}
