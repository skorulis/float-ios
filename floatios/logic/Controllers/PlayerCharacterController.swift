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
    let cityController:CityController
    
    init(actions:ActionController,city:CityController) {
        self.actionController = actions
        self.cityController = city;
        player = PlayerCharacterModel()
        self.cityController.add(occupant:player.base)
    }
    
    func performCharacterAction(action:CharacterAction) {
        self.actionController.performCharacterAction(character: player.base, action: action)
    }
    
}
