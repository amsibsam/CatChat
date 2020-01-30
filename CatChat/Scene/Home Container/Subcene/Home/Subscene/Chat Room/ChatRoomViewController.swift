//
//  ChatRoomViewControllerV2.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import UIKit
import AsyncDisplayKit

class ChatRoomViewController: ASViewController<ASDisplayNode> {
    
    // MARK: - UI Variable -
    private let inputTextNode: ChatInputNode = ChatInputNode()
    private let sendButtonNode: ChatSendButtonNode = ChatSendButtonNode()
    private let inputContainerNode: ChatInputContainerNode = ChatInputContainerNode()
    private let conversationTableNode: ASTableNode
    
    // MARK: - Constraint Variable -
    private var inputContainerHeightConstraint: NSLayoutConstraint?
    private var inputContainerBottomConstraint: NSLayoutConstraint?
    private var inputContainerUpperBottomConstraint: NSLayoutConstraint?
    
    private let viewModel: ChatRoomViewModel
    
    init(viewModel: ChatRoomViewModel) {
        self.viewModel = viewModel
        self.conversationTableNode = ChatTableNode(viewModel: viewModel)
        let mainNode = ASDisplayNode()
        mainNode.backgroundColor = .white
        mainNode.automaticallyManagesSubnodes = true
        super.init(node: mainNode)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSubNode()
        self.configureInputTextSizing()
        self.bindViewModel()
        self.viewModel.loadChat()
        self.sendButtonNode.didTap = { [unowned self] in
            self.sendTextComment()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.listenRoomEvent(isNeedToListen: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewModel.listenRoomEvent(isNeedToListen: false)
    }
    
    // MARK: - Private methods -
    private func bindViewModel() {
        self.viewModel.onChatTitleLoaded = { [weak self] title in
            self?.title = title
        }
        
        self.viewModel.onNeedReloadComment = { [weak self] in
            self?.conversationTableNode.reloadData()
        }
        
        self.viewModel.onSendingComment = { [weak self] insertedIndexPath in
            self?.conversationTableNode.insertRows(at: [insertedIndexPath], with: .right)
            self?.conversationTableNode.scrollToRow(at: insertedIndexPath, at: .top, animated: true)
        }
        
        self.viewModel.onReceivingComment = { [weak self] insertedIndexPath in
            self?.conversationTableNode.insertRows(at: [insertedIndexPath], with: .left)
            self?.conversationTableNode.scrollToRow(at: insertedIndexPath, at: .top, animated: true)
        }
        
        self.viewModel.onCommentSent = {
            print("::comment sent")
        }
        
        self.viewModel.onSendingCommentFailed = {
            print("::failed to sent comment")
        }
    }
    
    private func sendTextComment() {
        guard let textComment = self.inputTextNode.attributedText?.string else {
            return
        }
        
        self.viewModel.sendComment(withText: textComment)
        self.inputTextNode.attributedText = NSAttributedString(string: "")
    }
    
    private func configureInputTextSizing() {
        self.inputTextNode.delegate = self
    }
    
    private func configureSubNode() {
        self.node.addSubnode(self.conversationTableNode)
        self.node.addSubnode(self.inputContainerNode)
        self.inputContainerNode.addSubnode(self.inputTextNode)
        self.inputContainerNode.addSubnode(self.sendButtonNode)
        self.configureConstraint()
    }
    
    private func configureConstraint() {
        if #available(iOS 11.0, *) {
            inputContainerHeightConstraint = inputContainerNode.view.heightAnchor.constraint(equalToConstant: 40)
            inputContainerBottomConstraint = inputContainerNode.view.bottomAnchor.constraint(equalTo: self.node.view.safeAreaLayoutGuide.bottomAnchor)
            inputContainerUpperBottomConstraint = inputContainerNode.view.bottomAnchor.constraint(equalTo: self.node.view.bottomAnchor)
            NSLayoutConstraint.activate([
                // MARK: tableNode constraint
                self.conversationTableNode.view.topAnchor.constraint(equalTo: self.node.view.topAnchor),
                self.conversationTableNode.view.leftAnchor.constraint(equalTo: self.node.view.leftAnchor),
                self.conversationTableNode.view.rightAnchor.constraint(equalTo: self.node.view.rightAnchor),
                self.conversationTableNode.view.bottomAnchor.constraint(equalTo: inputContainerNode.view.topAnchor),
                
                // MARK: inputContainer constaint
                self.inputContainerNode.view.leftAnchor.constraint(equalTo: self.node.view.leftAnchor),
                self.inputContainerNode.view.rightAnchor.constraint(equalTo: self.node.view.rightAnchor),
                inputContainerBottomConstraint!,
                inputContainerHeightConstraint!,
                
                // MARK: tfInputNode constraint
                self.inputTextNode.view.topAnchor.constraint(equalTo: self.inputContainerNode.view.topAnchor, constant: 5),
                self.inputTextNode.view.bottomAnchor.constraint(equalTo: self.inputContainerNode.view.bottomAnchor, constant: -5),
                self.inputTextNode.view.leadingAnchor.constraint(equalTo: self.inputContainerNode.view.leadingAnchor, constant: 8),
                self.inputTextNode.view.trailingAnchor.constraint(equalTo: self.sendButtonNode.view.leadingAnchor, constant: 3),
                
                // MARK: btnSend constraint
                self.sendButtonNode.view.trailingAnchor.constraint(equalTo: self.inputContainerNode.view.trailingAnchor, constant: 8),
                self.sendButtonNode.view.centerYAnchor.constraint(equalTo: self.inputContainerNode.view.centerYAnchor),
                self.sendButtonNode.view.heightAnchor.constraint(equalToConstant: 50),
                self.sendButtonNode.view.widthAnchor.constraint(equalToConstant: 50)
            ])
        } else {
            inputContainerHeightConstraint = inputContainerNode.view.heightAnchor.constraint(equalToConstant: 40)
            inputContainerBottomConstraint = inputContainerNode.view.bottomAnchor.constraint(equalTo: self.node.view.bottomAnchor)
            inputContainerUpperBottomConstraint = inputContainerNode.view.bottomAnchor.constraint(equalTo: self.node.view.bottomAnchor)
            NSLayoutConstraint.activate([
                // MARK: tableNode constraint
                self.conversationTableNode.view.topAnchor.constraint(equalTo: self.node.view.topAnchor),
                self.conversationTableNode.view.leftAnchor.constraint(equalTo: self.node.view.leftAnchor),
                self.conversationTableNode.view.rightAnchor.constraint(equalTo: self.node.view.rightAnchor),
                self.conversationTableNode.view.bottomAnchor.constraint(equalTo: inputContainerNode.view.topAnchor),
                
                // MARK: inputContainer constaint
                self.inputContainerNode.view.leftAnchor.constraint(equalTo: self.node.view.leftAnchor),
                self.inputContainerNode.view.rightAnchor.constraint(equalTo: self.node.view.rightAnchor),
                inputContainerBottomConstraint!,
                inputContainerHeightConstraint!,
                
                // MARK: tfInputNode constraint
                self.inputTextNode.view.topAnchor.constraint(equalTo: self.inputContainerNode.view.topAnchor, constant: 5),
                self.inputTextNode.view.bottomAnchor.constraint(equalTo: self.inputContainerNode.view.bottomAnchor, constant: -5),
                self.inputTextNode.view.leadingAnchor.constraint(equalTo: self.inputContainerNode.view.leadingAnchor, constant: 8),
                self.inputTextNode.view.trailingAnchor.constraint(equalTo: self.sendButtonNode.view.leadingAnchor, constant: 3),
                
                // MARK: btnSend constraint
                self.sendButtonNode.view.trailingAnchor.constraint(equalTo: self.inputContainerNode.view.trailingAnchor, constant: 8),
                self.sendButtonNode.view.centerYAnchor.constraint(equalTo: self.inputContainerNode.view.centerYAnchor),
                self.sendButtonNode.view.heightAnchor.constraint(equalToConstant: 50),
                self.sendButtonNode.view.widthAnchor.constraint(equalToConstant: 50)
            ])
        }
    }
    
    private func calculateHeight() -> (input: CGRect, container: CGRect) {
        var inputTextNodeFrame = inputTextNode.frame
        inputTextNodeFrame.size.height = inputTextNode.textView.contentSize.height + 10
        
        var inputContainerFrame = inputContainerNode.frame
        inputContainerFrame.size.height = inputTextNode.textView.contentSize.height + 18
        return (inputTextNodeFrame, inputContainerFrame)
    }
}

// MARK: - ASEditableTextNodeDelegate -
extension ChatRoomViewController: ASEditableTextNodeDelegate {
    func editableTextNodeDidUpdateText(_ editableTextNode: ASEditableTextNode) {
        let fontHeight = editableTextNode.textView.font?.lineHeight
        let line = editableTextNode.textView.contentSize.height / fontHeight!
        
        if line < 4 {
            UIView.animate(withDuration: 0.1, animations: {
                self.inputContainerHeightConstraint?.constant = self.calculateHeight().container.height
            })
        }
    }
}
