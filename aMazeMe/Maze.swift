//
//  Maze.swift
//  aMazeMe
//
//  Created by Enzo Maruffa Moreira on 09/07/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import SpriteKit

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
    
    var startingPosition: CGPoint
    
    var matrix: [[MazeTile]]
    
    init(size: CGSize) {
        
        matrix = []
        
        for i in 0..<Int(size.height) {
            matrix.append([])
            for _ in 0..<Int(size.width) {
                matrix[i].append(MazeTile())
            }
        }
        
        startingPosition = .zero
        
        
    }
    
    static func fullyRandomMaze(size: CGSize) -> Maze {
        let maze = Maze(size: size)
        
        for tileRow in maze.matrix {
            for tile in tileRow {
                tile.randomize()
            }
        }
        
        return maze
    }
    
    // Reference: http://weblog.jamisbuck.org/2011/1/27/maze-generation-growing-tree-algorithm
    static func growingTreeMaze(size: CGSize) -> Maze {
        let maze = Maze(size: size)
        
        // Initializes the maze with all walls closed
        for tileRow in maze.matrix {
            for tile in tileRow {
                tile.closeWalls()
            }
        }
        
        var helperList: [CGPoint] = []
        
        for _ in 0..<(maze.width * maze.height) {
            if helperList.isEmpty {
                
                // Finds a random position that's currently not visited
                var randomPosition = CGPoint.randomPoint(minX: 0, maxX: size.width-1, minY: 0, maxY: size.height-1)
                var randomTile = maze.tile(in: randomPosition)
                
                while randomTile.status != .normal {
                    randomPosition = CGPoint.randomPoint(minX: 0, maxX: size.width-1, minY: 0, maxY: size.height-1)
                    randomTile = maze.tile(in: randomPosition)
                }
                
                randomTile.status = .visited
                
                helperList.append(randomPosition)
                
            } else {
                
                // Changing this logic completely changes the maze!
                let lastTilePosition = helperList.last!
                
                let unvisitedNeighboursPositions = maze.getTileNeighbours(in: lastTilePosition).filter( { maze.tile(in: $0).status == .normal } )
                
                // Gotta backtrack
                if unvisitedNeighboursPositions.isEmpty {
                    // Mark this tile as visited
                    // Remove it from the list
                } else {
                    // Get neighbour tile randomly
                    // Open walls between two tiles
                    // Add neighbour tile to list
                    
                }
                
            }
        }
        
        
        return maze
    }
    
    func tile(in position: CGPoint) -> MazeTile {
        return self.matrix[Int(position.y)][Int(position.x)]
    }
    
    func getTileNeighbours(in position: CGPoint) -> [CGPoint] {
        var neighbours: [CGPoint] = []
        
        if position.x != 0 {
            neighbours.append(CGPoint(x: position.x-1, y: position.y))
        }
        if position.y != 0 {
            neighbours.append(CGPoint(x: position.x, y: position.y-1))
        }
        if position.x != CGFloat(self.width-1) {
            neighbours.append(CGPoint(x: position.x+1, y: position.y))
        }
        if position.y != CGFloat(self.height-1) {
            neighbours.append(CGPoint(x: position.x, y: position.y+1))
        }
        
        return neighbours
    }
    
}

