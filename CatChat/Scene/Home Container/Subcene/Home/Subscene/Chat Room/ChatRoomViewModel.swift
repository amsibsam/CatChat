//
//  ChatRoomViewModel.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import QiscusCore

class ChatRoomViewModel {
    
    // MARK: - Private properties -
    private let navigator: ChatRoomNavigator
    private let partnerUserId: String
    private let interactor: ChatRoomInteractor
    private var room: RoomModel? = nil {
        didSet {
            self.listenRoomEvent(isNeedToListen: true)
        }
    }
    
    // MARK: - Public properties -
    var onChatTitleLoaded: ((String) -> Void)? = nil
    var onNeedReloadComment: (() -> Void)? = nil
    var onLoadChatFailed: ((String) -> Void)? = nil
    var onSendingComment: ((IndexPath) -> Void)? = nil
    var onCommentSent: (() -> Void)? = nil
    var onSendingCommentFailed: (() -> Void)? = nil
    var onReceivingComment: ((IndexPath) -> Void)? = nil
    var commentViewModels: [ChatCommentTextCellViewModel] = []
    
    init(navigator: ChatRoomNavigator, interactor: ChatRoomInteractor, partnerUserId: String) {
        self.navigator = navigator
        self.interactor = interactor
        self.partnerUserId = partnerUserId
    }
    
    // MARK: - Public Function -
    func listenRoomEvent(isNeedToListen: Bool) {
        if !isNeedToListen {
            self.room?.delegate = nil
            return
        }
        
        guard let room = self.room else {
            return
        }
        
        self.interactor.listenNewCommentEvent(onRoom: room) { (comment) in
            if !comment.isMyComment {
                self.commentViewModels.insert(ChatCommentTextCellViewModel(comment: comment), at: 0)
                self.onReceivingComment?(IndexPath(row: 0, section: 0))
            }
        }
    }
    
    func loadChat() {
        // fetch from local first
        self.fetchRoomAndCommentFromLocal()
        // finaly update value after got the result from server
        self.fetchRoomAndCommentFromServer()
    }
    
    func sendComment(withText text: String) {
        guard let roomId = self.room?.id else {
            return
        }
        
        self.interactor.sendComment(withText: text,
                                    inRoomWithId: roomId,
                                    onSending: { [unowned self] (comment) in
                                        self.commentViewModels.insert(ChatCommentTextCellViewModel(comment: comment), at: 0)
                                        self.onSendingComment?(IndexPath(row: 0, section: 0))},
                                    onStatusChanged: { [weak self] comment in
                                        guard let commentViewModel = self?.findCommentViewModel(fromComment: comment) else {
                                            return
                                        }
                                        
                                        commentViewModel.updateComment(comment: comment)})
    }
    
    // MARK: - Public Function -
    private func findCommentViewModel(fromComment comment: CommentModel) -> ChatCommentTextCellViewModel? {
        guard let commentViewModel = self.commentViewModels.filter({ (commentViewModel) -> Bool in
            return commentViewModel.commentUniqueId == comment.uniqId
        }).first else {
            return nil
        }
        
        return commentViewModel
    }
    
    private func fetchRoomAndCommentFromLocal() {
        if let roomWithComments = self.interactor.fetchLocalRoomAndComments(withRoomName: self.partnerUserId) {
            self.room = roomWithComments.room
            self.onChatTitleLoaded?(roomWithComments.room.name)
            self.commentViewModels = roomWithComments.comments.map({ (comment) -> ChatCommentTextCellViewModel in
                return ChatCommentTextCellViewModel(comment: comment)
            })
            self.onNeedReloadComment?()
        }
    }
    
    private func fetchRoomAndCommentFromServer() {
        QiscusCore.shared.chatUser(userId: self.partnerUserId, onSuccess: { [weak self] (room, comments) in
            self?.fetchRoomAndCommentFromLocal()
            }, onError: { [weak self] error in
                self?.onLoadChatFailed?(error.message)
        })
    }

}
