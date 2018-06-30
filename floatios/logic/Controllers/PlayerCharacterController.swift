//
//  PlayerCharacterController.swift
//  floatios
//
//  Created by Alexander Skorulis on 29/6/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit

class PlayerCharacterController {

    let player:PlayerCharacterModel
    let actionController:ActionController
    
    init(actions:ActionController) {
        self.actionController = actions
        player = PlayerCharacterModel()
    }
    
    func performCharacterAction(action:CharacterAction) {
        self.actionController.performCharacterAction(character: player.base, action: action)
    }
    
}
