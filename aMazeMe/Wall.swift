//
//  Wall.swift
//  aMazeMe
//
//  Created by Enzo Maruffa Moreira on 09/07/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import SpriteKit

class Wall: MazeTile {
    
    var node: SKNode
    
    init() {
        let size = CGSize(width: 10, height: 10)
        node = SKShapeNode(rectOf: size)
        node.physicsBody = SKPhysicsBody(rectangleOf: size)
        node.physicsBody?.pinned = true
        node.physicsBody?.allowsRotation = false
        
        (node as! SKShapeNode).fillColor = .red
    }

}
