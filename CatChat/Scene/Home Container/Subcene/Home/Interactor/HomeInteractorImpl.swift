//
//  HomeInteractorImpl.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import QiscusCore

class HomeInteractorImpl: HomeInteractor {
    private var onGotNewRoom: ((RoomModel) -> Void)? = nil
    private var onRoomUpdateComment: ((RoomModel) -> Void)? = nil
    private var onNeedReloadRooms: (() -> Void)? = nil
    
    func listenRoomChanges(onGotNewRoom: @escaping ((RoomModel) -> Void), onNeedReloadRooms: @escaping (() -> Void), onRoomUpdateComment: @escaping ((RoomModel) -> Void)) {
        self.onGotNewRoom = onGotNewRoom
        self.onNeedReloadRooms = onNeedReloadRooms
        self.onRoomUpdateComment = onRoomUpdateComment
        QiscusCore.delegate = self
    }
    
    func unlistenRoomChanges() {
        QiscusCore.delegate = nil
    }
 
    func fetchRoomsFromLocal() -> [RoomModel] {
        let localRooms = QiscusCore.database.room.all().filter { (room) -> Bool in
            return !(room.lastComment?.message.isEmpty ?? true)
        }
        
        localRooms.forEach { (room) in
            QiscusCore.shared.markAsDelivered(roomId: room.id, commentId: room.lastComment?.id ?? "")
        }
        
        return localRooms
    }
    
    func fetchRoomsFromServer(onFetchSuccess: @escaping (() -> Void),
                              onFetchFailed: @escaping ((String) -> Void)) {
        self.fetchAllRoomFromServer(page: 1, onComplete: {
            onFetchSuccess()
        }) { (error) in
            onFetchFailed(error)
        }
    }
    
    private func fetchAllRoomFromServer(page: Int,
                                        onComplete: @escaping (() -> Void),
                                        onError: @escaping ((String) -> Void)) {
        QiscusCore.shared.getAllChatRooms(showParticipant: true, showRemoved: false, showEmpty: false, page: page, limit: 10, onSuccess: { [weak self] (rooms, _) in
            guard let `self` = self else {
                return
            }
            
            if rooms.isEmpty {
                onComplete()
            } else {
                self.fetchAllRoomFromServer(page: page + 1, onComplete: onComplete, onError: onError)
            }
        }) { (error) in
            onError(error.message)
        }
    }
}

extension HomeInteractorImpl: QiscusCoreDelegate {
    func onRoomMessageReceived(_ room: RoomModel, message: CommentModel) {
        QiscusCore.shared.markAsDelivered(roomId: room.id, commentId: message.id)
        self.onRoomUpdateComment?(room)
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
        self.onNeedReloadRooms?()
    }
    
    func onRoom(deleted room: RoomModel) {
        
    }
    
    func gotNew(room: RoomModel) {
        self.onGotNewRoom?(room)
    }
    
    func onChatRoomCleared(roomId: String) {
        
    }
    
    
}
