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
    var status: MazeTileStatus
    
    init(walls: [WallPlace], type: MazeTileType) {
        self.walls = walls
        self.type = type
        self.status = .normal
    }
    
    init() {
        self.walls = []
        self.type = .blank
        self.status = .normal
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
    
    func openWall(wallType: WallPlace) {
        changeWall(wallType: wallType, closed: false)
    }
    
    func closeWall(wallType: WallPlace) {
        changeWall(wallType: wallType, closed: true)
    }
    
    func changeWall(wallType: WallPlace, closed: Bool) {
        if closed {
            self.walls.contains(wallType) ? nil : walls.append(wallType)
        } else {
            walls.removeAll(where: { $0 == wallType } )
        }
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
            let wallPlace = baseWalls.remove(at: randomIndex)
            self.closeWall(wallType: wallPlace)
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
