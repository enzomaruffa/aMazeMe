//
//  SKNodeExtensions.swift
//  YingPong
//
//  Created by Enzo Maruffa Moreira on 25/06/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import SpriteKit

extension SKNode {
    
    func addChildren(nodes: [SKNode]) {
        for node in nodes {
            self.addChild(node)
        }
    }
}
