//
//  TextWithIconNode.swift
//  PetShop
//
//  Created by Rahardyan Bisma Setya Putra on 06/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class TextWithIconNode: ASDisplayNode {
    private let textNode: ASTextNode = ASTextNode()
    private let iconNode: ASNetworkImageNode = ASNetworkImageNode()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    var text: String? {
        set {
            self.textNode.attributedText = NSAttributedString(string: newValue ?? "", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)])
        }
        get {
            return self.textNode.attributedText?.string
        }
    }
    
    var imageUrl: String? {
        set {
            self.iconNode.url = URL(string: newValue ?? "")
        }
        
        get {
            self.iconNode.url?.absoluteString
        }
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let iconSize = CGSize(width: self.textNode.attributedText?.size().height ?? 0, height: self.textNode.attributedText?.size().height ?? 0)
        self.iconNode.style.preferredSize = iconSize
        let horizontalSpec = ASStackLayoutSpec(direction: .horizontal,
                                               spacing: 2,
                                               justifyContent: .start,
                                               alignItems: .center,
                                               children: [self.iconNode, self.textNode])
        
        return horizontalSpec
    }
}
