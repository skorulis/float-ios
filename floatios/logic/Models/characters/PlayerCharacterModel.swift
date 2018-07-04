//
//  PlayerCharacterModel.swift
//  floatios
//
//  Created by Alexander Skorulis on 29/6/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit

class PlayerStatsModel {
    
    //How many times the player has performed each action
    var actionTimeStats:[String:Int] = [:]
    
    func didPerformAction(action:CharacterAction) {
        let count = actionTimeStats[action.rawValue] ?? 0
        actionTimeStats[action.rawValue] = count + 1
    }
    
}

class PlayerCharacterModel {

    let base:CharacterModel
    let stats:PlayerStatsModel
    
    init() {
        base = CharacterModel()
        stats = PlayerStatsModel()
    }
    
}
