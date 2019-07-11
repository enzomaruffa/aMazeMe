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
    
    init(walls: [WallPlace], type: MazeTileType) {
        self.walls = walls
        self.type = type
    }
    
    init() {
        self.walls = []
        self.type = .blank
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
    
    func openWalls() {
        self.walls = []
    }
    
    func closeWalls() {
        self.walls = [.top, .right, .left, .bottom]
    }
    
    func blank() {
        self.type = .blank
    }
    
    func hole() {
        self.type = .hole
    }
    
    func completion() {
        self.type = .completion
    }
    
    func randomize() {
        let wallsCount = Int.random(in: 0...2)
        
        self.walls = []
        
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
        
        self.type = tileType
    }
}
