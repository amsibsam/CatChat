//
//  CommentTextNode.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import QiscusCore

class ChatCommentTextCellNode: ASCellNode {
    private let textNode: ASTextNode = ASTextNode()
    private let commentStatusTextNode: ASTextNode = ASTextNode()
    
    private var comment: CommentModel? = nil
    private let viewModel: ChatCommentTextCellViewModel
    
    init(viewModel: ChatCommentTextCellViewModel) {
        self.viewModel = viewModel
        super.init()
        self.automaticallyManagesSubnodes = true
        self.placeholderEnabled = true
        self.bindViewModel()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        if comment?.isMyComment ?? false {
            return ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .center, alignItems: .center, children: [self.configuredCommentTextNode(), self.configuredCommentStatusTextNode()])
        } else {
            return ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .center, alignItems: .center, children: [self.configuredCommentTextNode()])
        }
        
    }
    
    private func configuredCommentTextNode() -> ASLayoutSpec {
        guard let comment = self.comment else {
            return ASLayoutSpec()
        }
        
        let textColor: UIColor = comment.isMyComment ? .white : .black
        let bubleColor: UIColor = comment.isMyComment ? .black : .gray
        let bublePosition: ASRelativeLayoutSpecPosition = comment.isMyComment ? .end : .start
        self.textNode.attributedText = NSAttributedString(string: comment.message,
                                                          attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                                                                       NSAttributedString.Key.foregroundColor: textColor])
        self.textNode.style.maxWidth = ASDimensionMake(UIScreen.main.bounds.width * 3/4)
        self.textNode.style.minWidth = ASDimensionMake(80)
        self.textNode.style.minHeight = ASDimensionMake(20)
        self.textNode.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.textNode.backgroundColor = bubleColor
        self.textNode.placeholderColor = bubleColor
        self.textNode.cornerRadius = 10
        self.textNode.clipsToBounds = true
        self.textNode.placeholderEnabled = true
        self.textNode.placeholderFadeDuration = 0.1
        
        let insetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10), child: self.textNode)
        let layoutSpec = ASRelativeLayoutSpec(horizontalPosition: bublePosition,
                                              verticalPosition: .start,
                                              sizingOption: [],
                                              child: insetSpec)
        
        return layoutSpec
    }
    
    private func configuredCommentStatusTextNode() -> ASLayoutSpec {
        guard let comment = self.comment else {
            return ASLayoutSpec()
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.right
        self.commentStatusTextNode.attributedText = NSAttributedString(string: comment.status.rawValue,
                                                          attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                                                                       NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                       NSAttributedString.Key.paragraphStyle: paragraphStyle])
        self.commentStatusTextNode.style.maxWidth = ASDimensionMake(UIScreen.main.bounds.width * 3/4)
        self.commentStatusTextNode.style.minWidth = ASDimensionMake(80)
        self.commentStatusTextNode.style.minHeight = ASDimensionMake(20)
        self.commentStatusTextNode.placeholderEnabled = true
        self.commentStatusTextNode.placeholderFadeDuration = 0.1
        
        let insetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 2, left: 0, bottom: 8, right: 0), child: self.commentStatusTextNode)
        let layoutSpec = ASRelativeLayoutSpec(horizontalPosition: .end,
                                              verticalPosition: .start,
                                              sizingOption: [],
                                              child: insetSpec)
        
        return layoutSpec
    }
    
    private func bindViewModel() {
        self.viewModel.onCommentUpdate = { [weak self] comment in
            guard let `self` = self else {
                return
            }
            
            self.comment = comment
            self.setNeedsLayout()
        }
    }
}
