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
    
    init() {
        
        matrix = []
        
//        matrix = [[MazeTile(walls: [.left, .top], type: .blank), MazeTile(walls: [.top], type: .blank), MazeTile(walls: [.right, .top], type: .blank)],
//               [MazeTile(walls: [.left], type: .blank), MazeTile(walls: [.right, .left, .bottom], type: .blank), MazeTile(walls: [.right], type: .blank)],
//        [MazeTile(walls: [.left, .bottom], type: .blank), MazeTile(walls: [.bottom], type: .blank), MazeTile(walls: [.right, .bottom], type: .blank)]]
        
        let randomSize = 40
        
        for i in 0...randomSize {
            matrix.append([])
            for _ in 0...randomSize {
                matrix[i].append(MazeTile.randomMazeTile())
            }
        }
        
    }
    
    
    
}
