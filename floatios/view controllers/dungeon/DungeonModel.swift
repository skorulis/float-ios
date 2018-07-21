//
//  DungeonModel.swift
//  floatios
//
//  Created by Alexander Skorulis on 20/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SpriteKit

class DungeonModel: NSObject {

    let terrain:SKTileMapNode
    let walls:SKTileMapNode
    
    init(terrain:SKTileMapNode,walls:SKTileMapNode) {
        self.terrain = terrain
        self.walls = walls
    }
    
}
