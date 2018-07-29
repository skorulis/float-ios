//
//  SpriteComponent.swift
//  floatios
//
//  Created by Alexander Skorulis on 25/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import GameplayKit

class SpriteComponent: GKComponent {

    var sprite:ASSpriteNode
    
    init(sprite:ASSpriteNode) {
        self.sprite = sprite
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func gridEntity() -> GridEntity {
        return self.entity! as! GridEntity
    }
    
    func moveTo(position:vector_int2) {
        let point = self.sprite.dungeonScene().pointFor(position: position)
        let action = SKAction.move(to: point, duration: 0.25)
        action.timingMode = .easeInEaseOut
        
        self.gridEntity().gridPosition = position
        
        self.sprite.run(action)    
    }
    
    func placeAt(position:vector_int2) {
        let point = self.sprite.dungeonScene().pointFor(position: position)
        self.sprite.position = point
        self.gridEntity().gridPosition = position
    }
    
}
