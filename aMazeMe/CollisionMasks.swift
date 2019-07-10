//
//  CollisionMasks.swift
//  aMazeMe
//
//  Created by Enzo Maruffa Moreira on 10/07/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import Foundation

class CollisionMasks {
    
    private static let CollisionCategoryBall: UInt32 = 1 << 0
    private static let CollisionCategoryMapElement: UInt32 = 1 << 1
    
    static var CollisionBall: UInt32 = CollisionCategoryBall
    static var CollisionMapElement: UInt32 = CollisionCategoryMapElement
    
}
