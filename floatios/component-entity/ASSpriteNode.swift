//
//  ASSpriteNode.swift
//  floatios
//
//  Created by Alexander Skorulis on 25/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import SpriteKit

class ASSpriteNode: SKSpriteNode {

    //Copied this field but not currently using it for anything
    weak var owner:SpriteComponent?
    
    func dungeonScene() -> DungeonScene {
        return self.scene! as! DungeonScene
    }
    
}
