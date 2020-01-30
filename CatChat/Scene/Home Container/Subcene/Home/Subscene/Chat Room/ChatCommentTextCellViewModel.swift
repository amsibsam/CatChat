//
//  ChatCommentTextCellNode.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import QiscusCore

class ChatCommentTextCellViewModel {
    private var comment: CommentModel {
        didSet {
            self.onCommentUpdate?(comment)
        }
    }
    
    var onCommentUpdate: ((CommentModel) -> Void)? = nil {
        didSet {
            self.onCommentUpdate?(self.comment)
        }
    }
    
    var commentId: String {
        get {
            return self.comment.id
        }
    }
    
    init(comment: CommentModel) {
        self.comment = comment
    }
    
    func updateComment(comment: CommentModel) {
        self.comment = comment
    }
}
