//
//  Coordinator.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import UIKit

protocol Coordinator {
    associatedtype NavigationMethod
    
    var navigationMethod: NavigationMethod { get }
    
    init(navigationMethod: NavigationMethod)
    
    func start()
}

