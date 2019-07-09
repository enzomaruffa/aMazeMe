//
//  Maze.swift
//  aMazeMe
//
//  Created by Enzo Maruffa Moreira on 09/07/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import Foundation

class Maze {
    
    var width: Int
    var height: Int
    
    var matrix: [[MazeTileType]]
    
    init() {
        width = 11
        height = 11
        
        matrix = [[.Wall, .Wall, .Wall, .Wall, .Wall, .EmptyWall, .Wall, .Wall, .Wall, .Wall, .Wall],
                [.Wall, .EmptyTile, .Wall, .EmptyTile, .Wall, .EmptyTile, .Wall, .EmptyTile, .Wall, .EmptyTile, .Wall],
                [.Wall, .Wall, .Wall, .Wall, .Wall, .EmptyTile, .Wall, .Wall, .Wall, .Wall, .Wall],
                [.Wall, .EmptyTile, .Wall, .EmptyTile, .Wall, .EmptyTile, .Wall, .EmptyTile, .Wall, .EmptyTile, .Wall],
                [.Wall, .Wall, .Wall, .Wall, .Wall, .EmptyTile, .Wall, .Wall, .Wall, .Wall, .Wall],
                [.Wall, .EmptyTile, .Wall, .EmptyTile, .Wall, .EmptyTile, .Wall, .EmptyTile, .Wall, .EmptyTile, .Wall],
                [.Wall, .Wall, .Wall, .Wall, .Wall, .EmptyTile, .Wall, .Wall, .Wall, .Wall, .Wall],
                [.Wall, .EmptyTile, .Wall, .EmptyTile, .Wall, .EmptyTile, .Wall, .EmptyTile, .Wall, .EmptyTile, .Wall],
                [.Wall, .Wall, .Wall, .Wall, .Wall, .EmptyTile, .Wall, .Wall, .Wall, .Wall, .Wall],
                [.Wall, .EmptyTile, .Wall, .EmptyTile, .Wall, .EmptyTile, .Wall, .EmptyTile, .Wall, .EmptyTile, .Wall],
                [.Wall, .Wall, .Wall, .Wall, .Wall, .EmptyWall, .Wall, .Wall, .Wall, .Wall, .Wall]]
    }
    
}
