//
//  ASButtonNode+Interaction.swift
//  PetShop
//
//  Created by Rahardyan Bisma Setya Putra on 06/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import AsyncDisplayKit

extension ASButtonNode {
    private struct AssociatedObject {
        static var key = "ASButtonNode_DidTap"
    }
    
    var didTap: (() -> Void)? {
        
        get {
            return objc_getAssociatedObject(self, &AssociatedObject.key) as? () -> Void
        }
        
        set {
            
            objc_setAssociatedObject(self, &AssociatedObject.key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            addTarget(
                self,
                action: #selector(buttonTapped(sender:)),
                forControlEvents: .touchUpInside
            )
        }
        
    }
    
    @objc private func buttonTapped(sender: Any) {
        didTap?()
    }
}
