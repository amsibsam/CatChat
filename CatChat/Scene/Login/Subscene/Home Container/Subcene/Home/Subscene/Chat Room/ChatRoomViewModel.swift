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
    private var roomId: String? = nil
    
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
        QiscusCore.delegate = self
    }
    
    // MARK: - Public Function -
    func loadChat() {
        // fetch from local first
        self.fetchRoomAndCommentFromLocal()
        // finaly update value after got the result from server
        self.fetchRoomAndCommentFromServer()
    }
    
    func sendComment(withText text: String) {
        guard let roomId = self.roomId else {
            return
        }
        
        self.interactor.sendComment(withText: text,
                                    inRoomWithId: roomId,
                                    onSending: { [unowned self] (comment) in
                                        self.commentViewModels.insert(ChatCommentTextCellViewModel(comment: comment), at: 0)
                                        self.onSendingComment?(IndexPath(row: 0, section: 0))},
                                    onSent: { [weak self] (_) in
                                        self?.onCommentSent?()},
                                    onFailed: { [weak self] (_) in
                                        self?.onSendingCommentFailed?()})
    }
    
    // MARK: - Public Function -
    private func fetchRoomAndCommentFromLocal() {
        if let roomWithComments = self.interactor.fetchLocalRoomAndComments(withRoomName: self.partnerUserId) {
            self.roomId = roomWithComments.room.id
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

extension ChatRoomViewModel: QiscusCoreDelegate {
    func onRoomMessageReceived(_ room: RoomModel, message: CommentModel) {
        if !message.isMyComment {
            self.commentViewModels.insert(ChatCommentTextCellViewModel(comment: message), at: 0)
            self.onReceivingComment?(IndexPath(row: 0, section: 0))
        }
    }
    
    func onRoomMessageDeleted(room: RoomModel, message: CommentModel) {
        
    }
    
    func onRoomDidChangeComment(comment: CommentModel, changeStatus status: CommentStatus) {
        
    }
    
    func onRoomMessageDelivered(message: CommentModel) {
        
    }
    
    func onRoomMessageRead(message: CommentModel) {
        
    }
    
    func onRoom(update room: RoomModel) {
        
    }
    
    func onRoom(deleted room: RoomModel) {
        
    }
    
    func gotNew(room: RoomModel) {
        
    }
    
    func onChatRoomCleared(roomId: String) {
        
    }
    
    
}
