//
//  BattleUIController.swift
//  floatios
//
//  Created by Alexander Skorulis on 28/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import SpriteKit
import FLGame

class BattleUIController {

    let dungeon:DungeonModel
    let scene:DungeonScene
    
    var overlays:[GridEntity] = []
    let overlayMap:SKTileMapNode
    
    init(dungeon:DungeonModel,scene:DungeonScene) {
        self.dungeon = dungeon
        self.scene = scene
        
        let tileSize = CGSize(width: 30, height: 35)
        let gen = TilesGenerator(tileSize: tileSize)
        let overlaySet = gen.battleTileSet()
        let size = 7
        let group = overlaySet.tileGroups.first!
        
        let rowGaps = [2,2,1,0,1,2,2]
        
        overlayMap = SKTileMapNode(tileSet: overlaySet, columns: size, rows: size, tileSize: tileSize)
        for i in 0..<size {
            let gap = rowGaps[i]
            for j in 0..<size {
                if j >= gap && j <= (size - gap) {
                    overlayMap.setTileGroup(group, forColumn: j, row: i)
                }
            }
        }
        var pos = scene.playerCentre()
        pos.x -= tileSize.width/4
        pos.y -= tileSize.height * 0.75
        
        overlayMap.position = pos
        //self.scene.addChild(overlayMap)
    }
    
    func handleTap(recognizer:UITapGestureRecognizer) {
        
    }
    
    func startBattle(frameWidth:CGFloat) {
        let points = self.activeSquares()
        let fade = SKAction.fadeIn(withDuration: 0.25)
        for p in points {
            let entity = overlayComponent(position: p)
            let sprite = entity.component(ofType: SpriteComponent.self)?.sprite
            sprite?.alpha = 0
            sprite?.run(fade)
            overlays.append(entity)
        }
        
        let scale = self.scene.tileSize.width * 3 / frameWidth
        let action = SKAction.scale(to: scale, duration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1)
        scene.camera?.run(action)
        
    }
    
    func finishBattle(completion:@escaping ()->Void) {
        for entity in overlays {
            let fade = SKAction.fadeOut(withDuration: 0.25)
            let remove = SKAction.run {
                self.scene.removeSprite(entity: entity)
            }
            let sequence = SKAction.sequence([fade,remove])
            entity.component(ofType: SpriteComponent.self)?.sprite.run(sequence)
        }
        self.overlayMap.removeFromParent()
        
        let action = SKAction.scale(to: 1, duration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1)
        let finishAction = SKAction.run(completion)
        let sequence = SKAction.sequence([action,finishAction])
        self.scene.camera?.run(sequence)
    }
    
    func middlePoint() -> vector_int2 {
        return dungeon.playerNode!.gridPosition
    }
    
    func activeSquares() -> [vector_int2] {
        let mid = self.middlePoint()
        let surrounding = mid.hexSurrounding
        let all = [mid] + surrounding
        return all.filter { self.dungeon.isInMap(x: Int($0.x), y: Int($0.y))}
    }
    
    private func overlayComponent(position:vector_int2) ->GridEntity {
        let entity = GridEntity()
        entity.gridPosition = position
        _ = self.scene.addSprite(entity: entity, imageNamed: "divider")
        return entity
    }
    
}
