//
//  SKTileMapNode+Additions.swift
//  floatios
//
//  Created by Alexander Skorulis on 21/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SpriteKit

extension SKTileMapNode {

    func tileDefinition(at:CGPoint) -> SKTileDefinition? {
        let column = Int(at.x)
        let row = Int(at.y)
        return tileDefinition(atColumn: column, row: row)
    }
    
    func tileGroup(at:CGPoint) -> SKTileGroup? {
        let column = Int(at.x)
        let row = Int(at.y)
        return tileGroup(atColumn: column, row: row)
    }
    
    func centerOfTile(at:CGPoint) -> CGPoint {
        return centerOfTile(atColumn: Int(at.x), row: Int(at.y))
    }
    
    func centreOfTile(at:vector_int2) -> CGPoint {
        return centerOfTile(atColumn: Int(at.x), row: Int(at.y))
    }
    
    
}
