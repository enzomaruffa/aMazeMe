//
//  MazeTile.swift
//  aMazeMe
//
//  Created by Enzo Maruffa Moreira on 09/07/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import SpriteKit

class MazeTile {
    
    var walls: [WallPlace]
    var type: MazeTileType
    
    internal init(walls: [WallPlace], type: MazeTileType) {
        self.walls = walls
        self.type = type
    }
    
}
