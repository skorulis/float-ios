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
    
    init(dungeon:DungeonModel,scene:DungeonScene) {
        self.dungeon = dungeon
        self.scene = scene
    }
    
    func startBattle(frameWidth:CGFloat) {
        let scale = self.scene.tileSize.width * 3 / frameWidth
        let action = SKAction.scale(to: scale, duration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1)
        scene.camera?.run(action)
    }
    
    func finishBattle(completion:@escaping ()->Void) {
        let action = SKAction.scale(to: 1, duration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1)
        let finishAction = SKAction.run(completion)
        let sequence = SKAction.sequence([action,finishAction])
        self.scene.camera?.run(sequence)
    }
    
    func middleSquare() -> vector_int2 {
        return dungeon.playerNode.gridPosition
    }
    
}
