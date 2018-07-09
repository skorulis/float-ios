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
    
    func performAction(action:ActionReferenceModel) {
        self.actionController.performAction(character: player.base, action: action)
        player.stats.didPerformAction(action: action.type)
    }
    
    func dayFinished() {
        actionController.endDay(character: player.base)
    }
    
}
