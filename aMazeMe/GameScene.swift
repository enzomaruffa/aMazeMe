//
//  GameScene.swift
//  aMazeMe
//
//  Created by Enzo Maruffa Moreira on 09/07/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let ballRadius: CGFloat = 20
    
    var ball: SKShapeNode!
    
    let wallSize: CGFloat = 20 * 2 + 20
    let tileSize: CGFloat = 20 * 2 + 20
    
    override func didMove(to view: SKView) {
        
        scene?.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        ball = SKShapeNode(circleOfRadius: ballRadius)
        ball.fillColor = .red
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
        ball.physicsBody?.mass = 100
        ball.physicsBody?.friction = 0.7
        ball.physicsBody?.linearDamping = 0.6
        ball.zPosition = 5
        
        
        scene?.addChild(ball)
        
        let maze = Maze()
        
        let halfWidth: CGFloat = CGFloat(maze.width / 2)
        let halfHeight: CGFloat = CGFloat(maze.height / 2)
        let mazeNodesWidth = (ceil(halfWidth) * wallSize) + (floor(halfWidth) * tileSize)
        let mazeNodesHeight = (ceil(halfHeight) * wallSize) + (floor(halfHeight) * tileSize)
        
        var position: CGPoint = CGPoint(x: -mazeNodesWidth/2, y: -mazeNodesHeight/2)
        var node: SKShapeNode
        
        for tileRow in maze.matrix {
            for tile in tileRow {
                
                if tile == .Wall {
                    node = SKShapeNode(rectOf: CGSize(width: wallSize, height: wallSize))
                    node.position = position
                    node.fillColor = .red
                    node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: wallSize, height: wallSize))
                    node.physicsBody?.pinned = true
                    node.physicsBody?.allowsRotation = false
                    node.physicsBody?.restitution = 0
                    position = CGPoint(x: position.x, y: position.y + wallSize)
                    scene?.addChild(node)
                } else if tile == .EmptyWall {
                    node = SKShapeNode(rectOf: CGSize(width: wallSize, height: wallSize))
                    node.position = position
                    node.fillColor = .white
                    position = CGPoint(x: position.x, y: position.y + wallSize)
                    scene?.addChild(node)
                } else if tile == .EmptyTile {
                    node = SKShapeNode(rectOf: CGSize(width: tileSize, height: tileSize))
                    node.position = position
                    node.fillColor = .white
                    position = CGPoint(x: position.x, y: position.y + tileSize)
                    scene?.addChild(node)
                }
                
            }
            position = CGPoint(x: position.x + tileSize, y: -mazeNodesHeight/2)
        }
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func updateGravity(gravity: CGVector) {
        scene?.physicsWorld.gravity = gravity
    }
}
