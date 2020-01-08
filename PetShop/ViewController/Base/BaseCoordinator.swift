//
//  BaseCoordinator.swift
//  PetShop
//
//  Created by Rahardyan Bisma Setya Putra on 08/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import Foundation
import UIKit
protocol BaseCoordniatorProtocol {
    associatedtype NavigationMethod
    
    var navigationMethod: NavigationMethod { get }
    
    init(navigationMethod: NavigationMethod)
    
    func start()
}
