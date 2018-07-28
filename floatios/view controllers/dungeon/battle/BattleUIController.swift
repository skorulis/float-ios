//
//  BattleUIController.swift
//  floatios
//
//  Created by Alexander Skorulis on 28/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import SpriteKit

class BattleUIController {

    let dungeon:DungeonModel
    let scene:DungeonScene
    
    var overlays:[GridEntity] = []
    
    init(dungeon:DungeonModel,scene:DungeonScene) {
        self.dungeon = dungeon
        self.scene = scene
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
        
        let action = SKAction.scale(to: 1, duration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1)
        let finishAction = SKAction.run(completion)
        let sequence = SKAction.sequence([action,finishAction])
        self.scene.camera?.run(sequence)
    }
    
    func middlePoint() -> vector_int2 {
        return dungeon.playerNode.gridPosition
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
