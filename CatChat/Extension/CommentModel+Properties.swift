//
//  CommentModel+Properties.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import QiscusCore

extension CommentModel {
    
    var isMyComment: Bool {
        get {
            return self.userId == (QiscusCore.getUserData()?.id ?? "")
        }
    }
}
