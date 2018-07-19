//
//  DungeonGenerator.swift
//  floatios
//
//  Created by Alexander Skorulis on 19/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SpriteKit

class DungeonGenerator {

    func generateDungeon(size:Int) -> SKTileMapNode {
        let tileSet = SKTileSet(named: "Overland")!
        
        let groups = tileSet.tileGroups.groupSingle { $0.name! }
        
        let tileMap = SKTileMapNode(tileSet: tileSet, columns: size, rows: size, tileSize: CGSize(width: 120, height: 140))
        
        for x in 0..<size {
            for y in 0..<size {
                let group = isEdge(x: x, y: y, size: size) ? groups["dirt"] : groups["grass"]
                tileMap.setTileGroup(group, forColumn: x, row: y)
            }
        }
        
        return tileMap
    }
    
    func isEdge(x:Int,y:Int,size:Int) -> Bool {
        return x == 0 || y == 0 || x == size - 1 || y == size - 1
    }
    
}
