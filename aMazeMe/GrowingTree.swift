//
//  GrowingTree.swift
//  aMazeMe
//
//  Created by Enzo Maruffa Moreira on 13/07/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import SpriteKit

class GrowingTreeAlgorithm {
    
    // Reference: http://weblog.jamisbuck.org/2011/1/27/maze-generation-growing-tree-algorithm
    static func generateMaze(withSize size: CGSize, using choosingFunction: ([CGPoint]) -> CGPoint, startingIn startingPoint: CGPoint, andEndingIn endingPoints: [CGPoint]) -> Maze {
        let maze = Maze(size: size, startingPoint: startingPoint, endingPoints: endingPoints)
        
        // Initializes the maze with all walls closed
        for tileRow in maze.matrix {
            for tile in tileRow {
                tile.closeWalls()
                tile.status = .normal
            }
        }
        
        var helperList: [CGPoint] = []
        
        // Finds a random position that's currently not visited
        var randomPosition = CGPoint.randomRoundedPoint(minX: 0, maxX: Int(size.width-1), minY: 0, maxY: Int(size.height-1))
        var randomTile = maze.tile(in: randomPosition)
        
//        while randomTile.status != .normal {
//            randomPosition = CGPoint.randomRoundedPoint(minX: 0, maxX: Int(size.width-1), minY: 0, maxY: Int(size.height-1))
//            randomTile = maze.tile(in: randomPosition)
//        }
        
        randomTile.status = .visited
        
        helperList.append(randomPosition)
        
        print("Adding first position", randomPosition)
        
        while !helperList.isEmpty {
            print("Running another iteration")
            // Changing this logic completely changes the maze!
            let selectedTilePosition = choosingFunction(helperList)
            
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
    
    static func recursiveBacktracking(points: [CGPoint]) -> CGPoint {
        return points.last!
    }
    
    static func randomElement(points: [CGPoint]) -> CGPoint {
        return points.randomElement()!
    }
    
}
