//
//  SKDungeonNode.swift
//  floatios
//
//  Created by Alexander Skorulis on 22/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SpriteKit

class SKDungeonNode: SKNode {

    let terrain:SKTileMapNode
    let walls:SKTileMapNode
    let dungeon:DungeonModel
    let terrainGroups:[String:SKTileGroup]
    let fixtureGroups:[String:SKTileGroup]
    
    init(dungeon:DungeonModel) {
        self.dungeon = dungeon
        let tileSize = CGSize(width: 60, height: 70)
        let gen = TilesGenerator(tileSize: tileSize)
        let terrainSet = gen.terrainTileSet()
        let fixtureSet = gen.dungeonTileSet()
        
        terrainGroups = terrainSet.tileGroups.groupSingle { $0.name! }
        fixtureGroups = fixtureSet.tileGroups.groupSingle { $0.name! }
        
        terrain = SKTileMapNode(tileSet: terrainSet, columns: dungeon.height, rows: dungeon.width, tileSize: tileSize)
        walls = SKTileMapNode(tileSet: fixtureSet, columns: dungeon.height, rows: dungeon.width, tileSize: tileSize)
        
        super.init()
        
        self.addChild(terrain)
        self.addChild(walls)
        
        self.rebuildMaps()
    }
    
    func rebuildMaps() {
        for y in 0..<dungeon.height {
            for x in 0..<dungeon.width {
                guard let node = dungeon.nodeAt(x: x, y: y) else { continue }
                terrain.setTileGroup(terrainGroup(terrain: node.terrain), forColumn: y, row: x)
                if let f = node.fixture {
                    walls.setTileGroup(fixtureGroup(fixture: f), forColumn: y, row: x)
                }
            }
        }
    }
    
    func terrainGroup(terrain:TerrainReferenceModel) -> SKTileGroup {
        let name = terrain.type.rawValue
        return terrainGroups[name]!
    }
    
    func fixtureGroup(fixture:DungeonTileReferenceModel) -> SKTileGroup {
        let name = fixture.type.rawValue
        return fixtureGroups[name]!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
