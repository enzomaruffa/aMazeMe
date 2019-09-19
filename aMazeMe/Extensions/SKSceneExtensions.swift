//
//  SKSceneExtensions.swift
//  spaceProgram
//
//  Created by Enzo Maruffa Moreira on 23/08/19.
//  Copyright © 2019 minichallenge. All rights reserved.
//

import SpriteKit


extension SKScene {
    func viewSizeInLocalCoordinates(ignoreCameraScale: Bool = false) -> CGSize {
        let reference = CGPoint(x: view!.bounds.maxX, y: view!.bounds.maxY)
        var bottomLeft = convertPoint(fromView: .zero)
        var topRight = convertPoint(fromView: reference)
        
        if ignoreCameraScale, let camera = camera {
            bottomLeft = camera.convert(bottomLeft, from: self)
            topRight = camera.convert(topRight, from: self)
        }
        
        let d = topRight - bottomLeft
        return CGSize(width: d.x, height: -d.y)
    }
}
