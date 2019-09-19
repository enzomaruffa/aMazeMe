//
//  GameConstants.swift
//  aMazeMe
//
//  Created by Enzo Maruffa Moreira on 11/09/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import CoreGraphics

class GameConstants {
    
    static let instance = GameConstants()
    
    var ballRadius: CGFloat
    var wallWidth: CGFloat
    var tileSize: CGFloat
    
    private init() {
        ballRadius = 15 
        wallWidth = 3
        tileSize = (ballRadius * 2) + (wallWidth * 2) + CGFloat(15)
    }
}
