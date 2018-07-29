//
//  DungeonScene.swift
//  floatios
//
//  Created by Alexander Skorulis on 22/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import SpriteKit

class DungeonScene: SKScene {

    let terrain:SKTileMapNode
    let walls:SKTileMapNode
    let dungeon:DungeonModel
    let terrainGroups:[String:SKTileGroup]
    let fixtureGroups:[String:SKTileGroup]
    let tileSize:CGSize
    
    init(dungeon:DungeonModel) {
        self.dungeon = dungeon
        tileSize = CGSize(width: 60, height: 70)
        
        let gen = TilesGenerator(tileSize: tileSize)
        let terrainSet = gen.terrainTileSet()
        let fixtureSet = gen.dungeonTileSet()
        
        terrainGroups = terrainSet.tileGroups.groupSingle { $0.name! }
        fixtureGroups = fixtureSet.tileGroups.groupSingle { $0.name! }
        
        terrain = SKTileMapNode(tileSet: terrainSet, columns: dungeon.width, rows: dungeon.height, tileSize: tileSize)
        walls = SKTileMapNode(tileSet: fixtureSet, columns: dungeon.width, rows: dungeon.height, tileSize: tileSize)
        
        super.init(size: .zero)
        
        self.scaleMode = .resizeFill
        self.addChild(terrain)
        self.addChild(walls)
        
        self.rebuildMaps()
        
        _ = addSprite(entity: dungeon.playerNode,imageNamed:"tank")
    }
    
    func addSprite(entity:GridEntity,imageNamed:String) -> ASSpriteNode {
        let node = ASSpriteNode(imageNamed: imageNamed)
        node.setScale(0.5)
        let spriteComponent = SpriteComponent(sprite: node)
        entity.addComponent(spriteComponent)
        self.addChild(node)
        spriteComponent.placeAt(position: entity.gridPosition)
        return node
    }
    
    func removeSprite(entity:GridEntity) {
        if let component = entity.component(ofType: SpriteComponent.self) {
            component.sprite.removeFromParent()
        }
    }
    
    func rebuildMaps() {
        for y in 0..<dungeon.height {
            for x in 0..<dungeon.width {
                guard let node = dungeon.nodeAt(x: x, y: y) else { continue }
                terrain.setTileGroup(terrainGroup(terrain: node.terrain), forColumn: x, row: y)
                if let f = node.fixture {
                    walls.setTileGroup(fixtureGroup(fixture: f), forColumn: x, row: y)
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
    
    func pointFor(position:vector_int2) -> CGPoint {
        return self.terrain.centreOfTile(at: position)
    }
    
    func playerCentre() -> CGPoint {
        return self.dungeon.playerNode.component(ofType: SpriteComponent.self)!.sprite.position
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}