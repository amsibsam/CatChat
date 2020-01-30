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
 
    func fetchRoomsFromLocal() -> [RoomModel] {
        return QiscusCore.database.room.all().filter { (room) -> Bool in
            return !(room.lastComment?.message.isEmpty ?? true)
        }
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
