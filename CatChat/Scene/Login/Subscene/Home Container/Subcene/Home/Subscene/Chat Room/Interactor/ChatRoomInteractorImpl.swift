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
            
            return (room: localRoom, comments: comments)
        }
        
        return nil
    }
    
    func sendComment(withText text: String,
                     inRoomWithId roomId: String,
                     onSending: @escaping ((CommentModel) -> Void),
                     onSent: @escaping ((CommentModel) -> Void),
                     onFailed: @escaping ((CommentModel) -> Void)) {
        
        let comment = CommentModel()
        comment.message = text
        comment.roomId = roomId
        
        onSending(comment)
        QiscusCore.shared.sendMessage(message: comment, onSuccess: { (sentComment) in
            onSent(sentComment)
        }) { (error) in
            onFailed(comment)
        }
    }
    
    
}
