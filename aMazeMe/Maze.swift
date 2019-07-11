//
//  Maze.swift
//  aMazeMe
//
//  Created by Enzo Maruffa Moreira on 09/07/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import Foundation

class Maze: Codable {
    
    var width: Int {
        get {
            return matrix[0].count
        }
    }
    var height: Int {
        get {
            return matrix.count
        }
    }
    
    var matrix: [[MazeTile]]
    
    init(size: Int) {
        
        matrix = []
        
        for i in 0...size {
            matrix.append([])
            for _ in 0...size {
                matrix[i].append(MazeTile())
            }
        }
        
    }
    
    static func fullyRandomMaze(size: Int) -> Maze {
        let maze = Maze(size: size)
        
        for tileRow in maze.matrix {
            for tile in tileRow {
                tile.randomize()
            }
        }
        
        return maze
    }
    
    static func growingTreeMaze(size: Int) -> Maze {
        let maze = Maze(size: size)
        
        for tileRow in maze.matrix {
            for tile in tileRow {
                tile.randomize()
            }
        }
        
        return maze
    }
    
}

