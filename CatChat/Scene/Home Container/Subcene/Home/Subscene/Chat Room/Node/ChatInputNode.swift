//
//  ChatInputNode.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class ChatInputNode: ASEditableTextNode {
    override init() {
        super.init()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.attributedPlaceholderText = NSAttributedString(string: "Type your message here",
                                                                        attributes: [
                                                                            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),
                                                                            NSAttributedString.Key.foregroundColor : UIColor.gray])
        self.typingAttributes = [NSAttributedString.Key.font.rawValue : UIFont.systemFont(ofSize: 14),
                                             NSAttributedString.Key.foregroundColor.rawValue : UIColor.black]
        self.textContainerInset = UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10)
        self.borderColor = UIColor.gray.cgColor
        self.borderWidth = 2
        self.cornerRadius = 6
    }
    
    override init(textKitComponents: ASTextKitComponents, placeholderTextKitComponents: ASTextKitComponents) {
        super.init(textKitComponents: textKitComponents, placeholderTextKitComponents: placeholderTextKitComponents)
    }
}
