//
//  NPCController.swift
//  floatios
//
//  Created by Alexander Skorulis on 29/6/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit

class NPCController {

    let actionController:ActionController
    let cityController:CityController
    var npcs:[NonPlayerCharacterModel] = []
    var nameGen = NameGenerator()
    
    init(actions:ActionController,city:CityController) {
        self.actionController = actions
        self.cityController = city;
        npcs.append(makeCharacter())
        npcs.append(makeCharacter())
        npcs.append(makeCharacter())
        npcs.append(makeCharacter())
        
        for npc in npcs {
            self.cityController.add(occupant: npc.base)
        }
    }
    
    private func makeCharacter() -> NonPlayerCharacterModel {
        let name = nameGen.getName()
        let base = CharacterModel(name: name)
        return NonPlayerCharacterModel(base: base)
    }
    
    public func dayFinished() {
        for npc in npcs {
            actionController.endDay(character: npc.base)
        }
    }
}
