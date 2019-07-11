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
    
    var ballRadius: CGFloat!
    
    var ball: SKShapeNode!
    
    var wallWidth: CGFloat!
    var tileSize: CGFloat!
    
    
    var cameraNode : SKCameraNode!
    
    override func didMove(to view: SKView) {
        
        ballRadius = 15
        wallWidth = 3
        tileSize = (ballRadius * 2) + (wallWidth * 2) + CGFloat(15)
        
        scene?.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        ball = SKShapeNode(circleOfRadius: ballRadius)
        setBallProperties(ball: ball)
        scene?.addChild(ball)
        
        let maze = Maze()
        
        let halfMazeWidth: CGFloat = CGFloat(maze.width / 2)
        let halfMazeHeight: CGFloat = CGFloat(maze.height / 2)
        let mazeNodesWidth =  (floor(halfMazeWidth) * tileSize)
        let mazeNodesHeight = (floor(halfMazeHeight) * tileSize)
        
        var position: CGPoint = CGPoint(x: -mazeNodesHeight, y: -mazeNodesWidth)
        var tileNode: SKShapeNode
        var wallNode: SKShapeNode
        
        for tileRow in maze.matrix {
            for tile in tileRow {
                
                tileNode = SKShapeNode(rectOf: CGSize(width: tileSize, height: tileSize))
                tileNode.fillColor = .black
                tileNode.strokeColor = .black
                
                // Add walls
                if tile.walls.contains(.left) {
                    let wallSize = CGSize(width: wallWidth, height: tileSize + wallWidth)
                    wallNode = SKShapeNode(rectOf: wallSize)
                    wallNode.physicsBody = SKPhysicsBody(rectangleOf: wallSize)
                    
                    setWallProperties(wall: wallNode)
                    
                    wallNode.position = CGPoint(x: -tileSize/2, y: 0)
                    tileNode.addChild(wallNode)
                }
                
                if tile.walls.contains(.top) {
                    let wallSize = CGSize(width: tileSize + wallWidth, height: wallWidth)
                    wallNode = SKShapeNode(rectOf: wallSize)
                    wallNode.physicsBody = SKPhysicsBody(rectangleOf: wallSize)
                    
                    setWallProperties(wall: wallNode)
                    
                    wallNode.position = CGPoint(x: 0, y: -tileSize/2)
                    tileNode.addChild(wallNode)
                }
                
                if tile.walls.contains(.right) {
                    let wallSize = CGSize(width: wallWidth, height: tileSize + wallWidth)
                    wallNode = SKShapeNode(rectOf: wallSize)
                    wallNode.physicsBody = SKPhysicsBody(rectangleOf: wallSize)
                    
                    setWallProperties(wall: wallNode)
                    
                    wallNode.position = CGPoint(x: tileSize/2, y: 0)
                    tileNode.addChild(wallNode)
                }
                
                if tile.walls.contains(.bottom) {
                    let wallSize = CGSize(width: tileSize + wallWidth, height: wallWidth)
                    wallNode = SKShapeNode(rectOf: wallSize)
                    wallNode.physicsBody = SKPhysicsBody(rectangleOf: wallSize)
                    
                    setWallProperties(wall: wallNode)
                    
                    wallNode.position = CGPoint(x: 0, y: tileSize/2)
                    tileNode.addChild(wallNode)
                }
            
                tileNode.position = position
                scene?.addChild(tileNode)
                
                position = CGPoint(x: position.x + tileSize, y: position.y)
            }
            position = CGPoint(x: -mazeNodesHeight, y: position.y + tileSize)
        }
        
        
        cameraNode = SKCameraNode()
        cameraNode.position = .zero
        scene!.addChild(cameraNode)
        scene!.camera = cameraNode
        
    }
    
    
    func setBallProperties(ball: SKShapeNode) {
        ball.fillColor = .yellow
        ball.strokeColor = .yellow
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
        ball.physicsBody?.mass = 100
        ball.physicsBody?.friction = 0.7
        ball.physicsBody?.linearDamping = 0.6
        ball.physicsBody?.collisionBitMask = CollisionMasks.CollisionBall
        ball.zPosition = 10
    }
    
    func setWallProperties(wall: SKShapeNode) {
        wall.fillColor = .white
        wall.strokeColor = .white
        wall.physicsBody?.mass = 10000
        wall.physicsBody?.collisionBitMask = CollisionMasks.CollisionMapElement
        wall.physicsBody?.isDynamic = false
        wall.physicsBody?.allowsRotation = false
        wall.zPosition = 7
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
        cameraNode.position = ball.position
    }
    
    func updateGravity(gravity: CGVector) {
        scene?.physicsWorld.gravity = gravity
    }
}
