//
//  DungeonCharacter.swift
//  floatios
//
//  Created by Alexander Skorulis on 23/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import GameplayKit

//Represents a character that can move around the dungeon
class DungeonCharacter: GridEntity {

    let ident:String
    let character:CharacterModel
    
    init(char:CharacterModel) {
        ident = UUID().uuidString
        self.character = char
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    weak var node:GKHexMapNode?
    
    override func isEqual(_ object: Any?) -> Bool {
        if let dc = object as? DungeonCharacter {
            return dc.ident == self.ident
        }
        return false
    }
    
}
