//
//  MazeTileStatus.swift
//  aMazeMe
//
//  Created by Enzo Maruffa Moreira on 11/07/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import Foundation

// Status are used in maze generation algorithm
enum MazeTileStatus: Int, Codable {
    case normal
    case visited
    case finished
}
