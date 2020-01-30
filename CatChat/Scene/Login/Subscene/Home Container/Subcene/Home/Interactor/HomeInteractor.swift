//
//  HomeInteractor.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import QiscusCore

protocol HomeInteractor {
    func listenRoomChanges(onGotNewRoom: @escaping ((RoomModel) -> Void), onNeedReloadRooms: @escaping (() -> Void))
    func unlistenRoomChanges()
    func fetchRoomsFromLocal() -> [RoomModel]
    func fetchRoomsFromServer(onFetchSuccess: @escaping (() -> Void),
                              onFetchFailed: @escaping ((String) -> Void))
}
