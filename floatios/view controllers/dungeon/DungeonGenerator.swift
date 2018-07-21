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

    func generateDungeon(size:Int) -> DungeonModel {
        let tileSize = CGSize(width: 120, height: 140)
        let gen = TilesGenerator(tileSize: tileSize)
        let tileSet = gen.terrainTileSet()
        let dungeonSet = gen.dungeonTileSet()
        
        let groups = tileSet.tileGroups.groupSingle { $0.name! }
        let dungeonGroups = dungeonSet.tileGroups.groupSingle { $0.name! }
        
        let terrainMap = SKTileMapNode(tileSet: tileSet, columns: size, rows: size, tileSize: tileSize)
        let wallMap = SKTileMapNode(tileSet: dungeonSet, columns: size, rows: size, tileSize: tileSize)
        
        let dungeon = DungeonModel(terrain: terrainMap, walls: wallMap)
        
        for x in 0..<size {
            for y in 0..<size {
                if (self.isEdge(x: x, y: y, size: size)) {
                    let group = dungeonGroups["wall"]
                    wallMap.setTileGroup(group, forColumn: x, row: y)
                }
                let group = isEdge(x: x, y: y, size: size) ? groups["dirt"] : groups["grass"]
                terrainMap.setTileGroup(group, forColumn: x, row: y)
            }
        }
        
        return dungeon
    }
    
    func isEdge(x:Int,y:Int,size:Int) -> Bool {
        return x == 0 || y == 0 || x == size - 1 || y == size - 1
    }
    
}
