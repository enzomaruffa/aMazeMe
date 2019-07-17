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
    var mazeRootNode: SKShapeNode!
    
    var wallWidth: CGFloat!
    var tileSize: CGFloat!
    
    var endingNodes: [SKShapeNode]! = []
    
    var cameraNode : SKCameraNode!
    
    var playing = true
    
    //        let mazeSize = CGSize(width: 11, height: 23)
    let mazeSize = CGSize(width: 8, height: 20)
    
    var maxPosition: CGPoint!
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = .black
        
        maxPosition = CGPoint(x: Int(mazeSize.width)-1, y: Int(mazeSize.height)-1)
        
        mazeRootNode = SKShapeNode(circleOfRadius: 0)
        scene?.addChild(mazeRootNode)
        
        ballRadius = 15
        wallWidth = 3
        tileSize = (ballRadius * 2) + (wallWidth * 2) + CGFloat(15)
        
        scene?.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        ball = SKShapeNode(circleOfRadius: ballRadius)
        setBallProperties(ball: ball)
        scene?.addChild(ball)
        
        let createdMaze = createMap(lastEndingPos: .zero)
        
        createCameraNode(createdMaze)
        
        // Add ball to scene
        positionBall(inMaze: createdMaze)
    }
    
    func addMazeToNode(mazeRootNode: SKShapeNode, maze: Maze) {
        var position: CGPoint = .zero
        var tileNode: SKShapeNode
        
        for tileRow in maze.matrix {
            for tile in tileRow {
                
                tileNode = SKShapeNode(rectOf: CGSize(width: tileSize, height: tileSize))
                tileNode.zPosition = 3
                
                if tile.type == .blank {
                    tileNode.fillColor = .black
                    tileNode.strokeColor = .black
                } else if tile.type == .completion {
                    tileNode.fillColor = .yellow
                    tileNode.strokeColor = .black
                    
                    endingNodes.append(tileNode)
                } else if tile.type == .hole {
                    let holeNode = SKShapeNode(circleOfRadius: ballRadius)
                    holeNode.fillColor = .white
                    tileNode.addChild(holeNode)
                    
                    tileNode.fillColor = .black
                    tileNode.strokeColor = .black
                }
                
                // Add walls
                if tile.walls.contains(.left) {
                    addLeftWall(tile: tileNode)
                }
                
                if tile.walls.contains(.top) {
                    addTopWall(tile: tileNode)
                }
                
                if tile.walls.contains(.right) {
                    addRightWall(tile: tileNode)
                }
                
                if tile.walls.contains(.bottom) {
                    addBottomWall(tile: tileNode)
                }
                
                tileNode.position = position
                mazeRootNode.addChild(tileNode)
                
                position = CGPoint(x: position.x + tileSize, y: position.y)
            }
            position = CGPoint(x: 0, y: position.y + tileSize)
        }
    }
    
    func addLeftWall(tile: SKShapeNode) {
        let wallSize = CGSize(width: wallWidth, height: tileSize + wallWidth/2)
        let wallNode = SKShapeNode(rectOf: wallSize)
        wallNode.physicsBody = SKPhysicsBody(rectangleOf: wallSize)
        
        setWallProperties(wall: wallNode)
        
        wallNode.position = CGPoint(x: -tileSize/2, y: 0)
        tile.addChild(wallNode)
    }
    
    func addTopWall(tile: SKShapeNode) {
        let wallSize = CGSize(width: tileSize + wallWidth/2, height: wallWidth)
        let wallNode = SKShapeNode(rectOf: wallSize)
        wallNode.physicsBody = SKPhysicsBody(rectangleOf: wallSize)
        
        setWallProperties(wall: wallNode)
        
        wallNode.position = CGPoint(x: 0, y: -tileSize/2)
        tile.addChild(wallNode)
    }
    
    func addRightWall(tile: SKShapeNode) {
        let wallSize = CGSize(width: wallWidth, height: tileSize + wallWidth/2)
        let wallNode = SKShapeNode(rectOf: wallSize)
        wallNode.physicsBody = SKPhysicsBody(rectangleOf: wallSize)
        
        setWallProperties(wall: wallNode)
        
        wallNode.position = CGPoint(x: tileSize/2, y: 0)
        tile.addChild(wallNode)
    }
    
    func addBottomWall(tile: SKShapeNode) {
        let wallSize = CGSize(width: tileSize + wallWidth/2, height: wallWidth)
        let wallNode = SKShapeNode(rectOf: wallSize)
        wallNode.physicsBody = SKPhysicsBody(rectangleOf: wallSize)
        
        setWallProperties(wall: wallNode)
        
        wallNode.position = CGPoint(x: 0, y: tileSize/2)
        tile.addChild(wallNode)
    }
    
    
    func setBallProperties(ball: SKShapeNode) {
        ball.fillColor = .yellow
        ball.strokeColor = .yellow
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
        ball.physicsBody?.mass = 150
        ball.physicsBody?.friction = 0.66
        ball.physicsBody?.linearDamping = 0.6
        ball.physicsBody?.collisionBitMask = CollisionMasks.CollisionBall
        ball.zPosition = 10
    }
    
    func setWallProperties(wall: SKShapeNode) {
        wall.fillColor = .white
        wall.strokeColor = .white
        wall.physicsBody?.collisionBitMask = CollisionMasks.CollisionMapElement
        wall.physicsBody?.isDynamic = false
        wall.physicsBody?.allowsRotation = false
        wall.zPosition = 7
    }
    
    func positionBall(inMaze maze: Maze) {
        let scenePosition = maze.startingPoint * tileSize
        ball.position = scenePosition
    }
    
    fileprivate func createCameraNode(_ maze: Maze) {
        let totalMazeWidth = tileSize * CGFloat(maze.width-1)
        let totalMazeHeight = tileSize * CGFloat(maze.height-1)
        
        let mazeCenter = CGPoint(x: totalMazeWidth, y:totalMazeHeight) / 2
        cameraNode = SKCameraNode()
        cameraNode.position = mazeCenter
        scene!.addChild(cameraNode)
        scene!.camera = cameraNode
        
        // Maze should be max 0.8 of the screen's height and 0.9 of screen's width
        let viewFrame = scene?.view?.frame ?? CGRect(x: 0, y: 0, width: totalMazeWidth, height: totalMazeHeight)
        
        let widthProportion = totalMazeWidth / viewFrame.width
        print("width propostion", widthProportion)
        let heightProportion = totalMazeHeight / viewFrame.height
        print("height propostion", heightProportion)
        
        let maxWidth: CGFloat = 0.9
        let maxHeight: CGFloat = 0.8
        
        if widthProportion > heightProportion { //should scale width
            print("setting scale by width", maxWidth / widthProportion)
            cameraNode?.setScale( widthProportion / maxWidth )
        } else { // shoud scale height
            print("setting scale by height", maxHeight / heightProportion)
            cameraNode?.setScale( heightProportion / maxHeight )
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
        //cameraNode.position = ball.position
        
        if let endingTile = checkGameEnding() {
            print("Has ending")
            if playing {
                print("Is playing")
                endMap(tile: endingTile)
            }
        }
    }
    
    func endMap(tile: SKShapeNode) {
        scene?.physicsWorld.gravity = .zero
        
        playing = false
        self.endingNodes = []
        
        ball.physicsBody?.velocity = .zero
        ball.run(SKAction.move(to: tile.position, duration: 0.3))
        
        mazeRootNode.run(SKAction.fadeAlpha(to: 0, duration: 0.5))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            let lastPosition = tile.position / self.tileSize
            
            // Destroy map
            self.mazeRootNode.removeAllChildren()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.createMap(lastEndingPos: lastPosition)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.mazeRootNode.run(SKAction.fadeAlpha(to: 1, duration: 1))
            self.playing = true
        }
    }
    
    func createMap(lastEndingPos: CGPoint) -> Maze {
        // Create a new map
        let endingPos: CGPoint = lastEndingPos == .zero ? maxPosition : .zero
        let maze = Maze(fileName: "SampleMaze")//GrowingTreeAlgorithm.generateMaze(withSize: mazeSize, using: GrowingTreeAlgorithm.recursiveBacktracking, startingIn: lastEndingPos, andEndingIn: [endingPos])
        
        addMazeToNode(mazeRootNode: mazeRootNode, maze: maze)
        
        return maze
    }
    
    func checkGameEnding() -> SKShapeNode? {
        return endingNodes.filter({ $0.contains(ball.position) }).first
    }
    
    func updateGravity(gravity: CGVector) {
        if playing {
            scene?.physicsWorld.gravity = gravity
        }
    }
}
