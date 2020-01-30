//
//  ChatTableNode.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class ChatTableNode: ASTableNode {
    private let viewModel: ChatRoomViewModel
    
    init(viewModel: ChatRoomViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)
        self.view.transform = CGAffineTransform(rotationAngle: (-.pi))
        self.view.transform = CGAffineTransform(scaleX: 1, y: -1)
        self.view.showsVerticalScrollIndicator = true
//        self.view.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: self.bounds.size.width + 10)
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.showsVerticalScrollIndicator = true
        self.view.separatorStyle = .none
        self.delegate = self
        self.dataSource = self
    }
}

extension ChatTableNode: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.commentViewModels.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            let cell = ChatCommentTextCellNode(viewModel: self.viewModel.commentViewModels[indexPath.row])
            
            DispatchQueue.main.async {
                cell.view.transform = CGAffineTransform(rotationAngle: (-.pi))
                cell.view.transform = CGAffineTransform(scaleX: 1, y: -1)
            }
            
            return cell
        }
    }
}

extension ChatTableNode: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        tableNode.deselectRow(at: indexPath, animated: true)
    }
}
