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
        
        // Finds a random position that's currently not visited
        var randomPosition = CGPoint.randomRoundedPoint(minX: 0, maxX: Int(size.width-1), minY: 0, maxY: Int(size.height-1))
        var randomTile = maze.tile(in: randomPosition)
        
        while randomTile.status != .normal {
            randomPosition = CGPoint.randomRoundedPoint(minX: 0, maxX: Int(size.width-1), minY: 0, maxY: Int(size.height-1))
            randomTile = maze.tile(in: randomPosition)
        }
        
        randomTile.status = .visited
        
        helperList.append(randomPosition)
        
        print("Adding first position", randomPosition)
        
        while !helperList.isEmpty {
            print("Running another iteration")
            // Changing this logic completely changes the maze!
            let selectedTilePosition = helperList.last!
            
            print("Selected position", selectedTilePosition)
            
            let unvisitedNeighboursPositions = maze.getTileNeighbours(in: selectedTilePosition).filter( { maze.tile(in: $0).status == .normal } )
            
            // Gotta backtrack
            if unvisitedNeighboursPositions.isEmpty { // Every neighbour has already been visited
                
                print("    No neighbours, backtracking...")
                
                // Mark tile as visited
                let tile = maze.tile(in: selectedTilePosition)
                tile.status = .finished
                
                // Remove it from the helper list
                helperList.removeAll(where: { $0 == selectedTilePosition } )
            } else {
                // Get neighbour tile randomly
                let neighbourPosition = unvisitedNeighboursPositions.randomElement()!
                
                print("    Neighbour position", neighbourPosition)
                // Open walls between two tiles
                let tile = maze.tile(in: selectedTilePosition)
                let neighbour = maze.tile(in: neighbourPosition)
                
                if neighbourPosition.y < selectedTilePosition.y { // Neighbour is on top
                    tile.openWall(wallType: .top)
                    neighbour.openWall(wallType: .bottom)
                } else if neighbourPosition.y > selectedTilePosition.y {  // Neighbour is on under
                    tile.openWall(wallType: .bottom)
                    neighbour.openWall(wallType: .top)
                    
                } else {
                    if neighbourPosition.x < selectedTilePosition.x { // Neighbour is on the left
                        tile.openWall(wallType: .left)
                        neighbour.openWall(wallType: .right)
                    } else if neighbourPosition.x > selectedTilePosition.x {  // Neighbour is on the right
                        tile.openWall(wallType: .right)
                        neighbour.openWall(wallType: .left)
                    }
                }
                
                // Mark neighbour as visited
                neighbour.status = .visited
                
                // Add neighbour tile to list
                helperList.append(neighbourPosition)
                
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

