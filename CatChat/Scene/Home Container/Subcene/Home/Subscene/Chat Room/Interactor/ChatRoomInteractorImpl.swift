//
//  ChatRoomInteractorImpl.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import QiscusCore

class ChatRoomInteractorImpl: ChatRoomInteractor {
    private var onGotNewComment: ((CommentModel) -> Void)? = nil
    private var onStatusChanged: ((CommentModel) -> Void)? = nil
    private var room: RoomModel? = nil
    
    func listenNewCommentEvent(onRoom room: RoomModel, onGotNewComment: @escaping ((CommentModel) -> Void)) {
        self.onGotNewComment = onGotNewComment
        self.room = room
        self.room?.delegate = self
    }
    
    func unlistenNewCommentEvent() {
        self.room?.delegate = nil
    }

    func fetchRoomFromServer(withPartnerId partnerId: String,
                             onFetchSuccess: @escaping (() -> Void),
                             onFetchError: @escaping ((String) -> Void)) {
        
        QiscusCore.shared.chatUser(userId: partnerId, onSuccess: { (room, comments) in
            onFetchSuccess()
            }, onError: { error in
                onFetchError(error.message)
        })
    }
    
    func fetchLocalRoomAndComments(withRoomName roomName: String) -> (room: RoomModel, comments: [CommentModel])? {
        
        if let localRoom = QiscusCore.database.room.find(predicate: NSPredicate(format: "name == %@", roomName))?.first {
            var comments: [CommentModel] = []
            if let localComments = QiscusCore.database.comment.find(roomId: localRoom.id) {
                comments = localComments
            }
            
            self.readAllComments(comments: comments)
            return (room: localRoom, comments: comments)
        }
        
        return nil
    }
    
    func sendComment(withText text: String,
                     inRoomWithId roomId: String,
                     onSending: @escaping ((CommentModel) -> Void),
                     onStatusChanged: @escaping ((CommentModel) -> Void)) {
        self.onStatusChanged = onStatusChanged
        let comment = CommentModel()
        comment.message = text
        comment.roomId = roomId
        
        onSending(comment)
        QiscusCore.shared.sendMessage(message: comment, onSuccess: { [weak self] (sentComment) in
            self?.onStatusChanged?(sentComment)
        }) { [weak self] (error) in
            comment.status = .failed
            self?.onStatusChanged?(comment)
        }
    }
    
    private func readAllComments(comments: [CommentModel]) {
        comments.forEach { (comment) in
            QiscusCore.shared.markAsRead(roomId: comment.roomId, commentId: comment.id)
        }
    }
}

extension ChatRoomInteractorImpl: QiscusCoreRoomDelegate {
    func onMessageReceived(message: CommentModel) {
        guard let roomId = self.room?.id else {
            return
        }
        
        QiscusCore.shared.markAsRead(roomId: roomId, commentId: message.id)
        self.onGotNewComment?(message)
    }
    
    func didComment(comment: CommentModel, changeStatus status: CommentStatus) {
        
    }
    
    func onMessageDelivered(message: CommentModel) {
        self.onStatusChanged?(message)
    }
    
    func onMessageRead(message: CommentModel) {
        self.onStatusChanged?(message)
    }
    
    func onMessageDeleted(message: CommentModel) {
        
    }
    
    func onUserTyping(userId: String, roomId: String, typing: Bool) {
        
    }
    
    func onUserOnlinePresence(userId: String, isOnline: Bool, lastSeen: Date) {
        
    }
    
    func onRoom(update room: RoomModel) {
        
    }
    
    
}
