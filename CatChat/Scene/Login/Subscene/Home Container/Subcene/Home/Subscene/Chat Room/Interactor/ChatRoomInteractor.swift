//
//  HomeInteractor.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import QiscusCore

protocol ChatRoomInteractor {
    func sendComment(withText text: String,
                     inRoomWithId rooId: String,
                     onSending: @escaping ((CommentModel) -> Void),
                     onSent: @escaping ((CommentModel) -> Void),
                     onFailed: @escaping ((CommentModel) -> Void))
    
    func fetchLocalRoomAndComments(withRoomName roomName: String) -> (room: RoomModel, comments: [CommentModel])?
    
    func fetchRoomFromServer(withPartnerId partnerId: String,
                             onFetchSuccess: @escaping (() -> Void),
                             onFetchError: @escaping ((String) -> Void))
}
