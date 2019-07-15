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

