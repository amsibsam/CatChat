//
//  RoomModel.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import QiscusCore

extension RoomModel {
    var partner: MemberModel? {
        return self.participants?.filter { participant in
            return participant.id != (QiscusCore.getUserData()?.username ?? "")
        }.first
    }
}
