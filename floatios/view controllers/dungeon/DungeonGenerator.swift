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

    let dungeon:DungeonModel
    let size:Int
    let terrainGroups:[String:SKTileGroup]
    let dungeonGroups:[String:SKTileGroup]
    
    init(size:Int) {
        let tileSize = CGSize(width: 60, height: 70)
        let gen = TilesGenerator(tileSize: tileSize)
        let tileSet = gen.terrainTileSet()
        let dungeonSet = gen.dungeonTileSet()
        
        let terrainMap = SKTileMapNode(tileSet: tileSet, columns: size, rows: size, tileSize: tileSize)
        let wallMap = SKTileMapNode(tileSet: dungeonSet, columns: size, rows: size, tileSize: tileSize)
        
        dungeon = DungeonModel(terrain: terrainMap, walls: wallMap)
        terrainGroups = dungeon.terrain.tileSet.tileGroups.groupSingle { $0.name! }
        dungeonGroups = dungeon.walls.tileSet.tileGroups.groupSingle { $0.name! }
        self.size = size
    }
    
    func generateDungeon() -> DungeonModel {
        let wallMap = dungeon.walls
        let terrainMap = dungeon.terrain
        
        for x in 0..<size {
            for y in 0..<size {
                if (self.isEdge(x: x, y: y, size: size)) {
                    let group = dungeonGroups["wall"]
                    wallMap.setTileGroup(group, forColumn: x, row: y)
                }
                let group = isEdge(x: x, y: y, size: size) ? terrainGroups["dirt"] : terrainGroups["grass"]
                terrainMap.setTileGroup(group, forColumn: x, row: y)
            }
        }
        for _ in 0...10 {
            addRoom()
        }
        
        return dungeon
    }
    
    func addRoom() {
        let x = arc4random_uniform(UInt32(size - 10))
        let y = arc4random_uniform(UInt32(size - 10))
        
        let width = arc4random_uniform(6) + 3
        let height = arc4random_uniform(6) + 3
        
        let wallGroup = dungeonGroups["wall"]
        let floorGroup = terrainGroups["floor"]
        
        let endX = x+width
        let endY = y+height
        
        for i in x...endX {
            for j in y...endY {
                if (i == x || j == y || i == endX || j == endY) {
                    dungeon.walls.setTileGroup(wallGroup, forColumn: Int(j), row: Int(i))
                }
                dungeon.terrain.setTileGroup(floorGroup, forColumn: Int(j), row: Int(i))
            }
        }
        
    }
    
    func isEdge(x:Int,y:Int,size:Int) -> Bool {
        return x == 0 || y == 0 || x == size - 1 || y == size - 1
    }
    
}
