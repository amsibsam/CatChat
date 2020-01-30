//
//  HomeWithChatNode.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class HomeWithChatNode: ASDisplayNode {
    
    private let viewModel: HomeViewModel
    private let chatRoomTableNode: ASTableNode = ASTableNode(style: .plain)
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init()
        self.automaticallyManagesSubnodes = true
        self.chatRoomTableNode.delegate = self
        self.chatRoomTableNode.dataSource = self
        self.bindViewModel()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let chatsInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6), child: self.configuredChatRoomTableNode())
        
        let emptyInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6), child: HomeEmptyChatNode(viewModel: self.viewModel))
        
        if self.viewModel.isLocalRoomEmpty() {
            return emptyInsetSpec
        } else {
            return chatsInsetSpec
        }
    }
    
    private func configuredChatRoomTableNode() -> ASDisplayNode {
        self.chatRoomTableNode.view.showsVerticalScrollIndicator = true
        self.chatRoomTableNode.view.tableFooterView = UIView()
        
        return self.chatRoomTableNode
    }
    
    private func bindViewModel() {
        self.viewModel.onNeedReloadRooms = { [weak self] in
            self?.chatRoomTableNode.reloadData()
        }
        
        self.viewModel.onNeedReconfigNode = { [weak self] in
            self?.setNeedsLayout()
        }
    }
}

extension HomeWithChatNode: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.chatRooms.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            let cellViewModel = self.viewModel.createRoomCellViewModel(forIndexPath: indexPath)
            let cellNode = HomeChatRoomCellNode(viewModel: cellViewModel)
            
            return cellNode
        }
    }
    
}

extension HomeWithChatNode: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        tableNode.deselectRow(at: indexPath, animated: true)
        self.viewModel.startChat(with: indexPath)
    }
}
