//
//  EmptyTile.swift
//  aMazeMe
//
//  Created by Enzo Maruffa Moreira on 09/07/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import SpriteKit

class EmptyTile: MazeTile {
    var node: SKNode
    
    init() {
        let size = CGSize(width: 30, height: 30)
        node = SKShapeNode(rectOf: size)
        node.physicsBody = SKPhysicsBody(rectangleOf: size)
        node.physicsBody?.pinned = true
        node.physicsBody?.allowsRotation = false
        
        (node as! SKShapeNode).fillColor = .white
    }
}
