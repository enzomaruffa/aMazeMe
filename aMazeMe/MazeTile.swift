//
//  MazeTile.swift
//  aMazeMe
//
//  Created by Enzo Maruffa Moreira on 09/07/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import SpriteKit

class MazeTile: Codable {
    
    var walls: [WallPlace]
    var type: MazeTileType
    
    internal init(walls: [WallPlace], type: MazeTileType) {
        self.walls = walls
        self.type = type
    }
    
    static func randomMazeTile() -> MazeTile {
        let wallsCount = Int.random(in: 0...2)
        var walls: [WallPlace] = []
        
        var baseWalls: [WallPlace] = [.left, .right, .top, .bottom]
        
        for _ in 0..<wallsCount {
            let randomIndex = Int.random(in: 0..<baseWalls.count)
            walls.append(baseWalls.remove(at: randomIndex))
        }
        
        let type = Int.random(in: 0..<100)
        
        var tileType = MazeTileType.blank
        
        if type == 0 {
            tileType = .completion
        } else if type > 0 && type < 4 {
            tileType = .hole
        }
        return MazeTile(walls: walls, type: tileType)
        
    }
}
