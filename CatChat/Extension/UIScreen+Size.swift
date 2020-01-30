//
//  UIScreen+Size.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import UIKit

extension UIScreen {
    var isIphoneSEKind: Bool {
        get {
            return UIScreen.main.bounds.width == 320
        }
    }
}
