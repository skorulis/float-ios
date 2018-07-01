//
//  ActionController.swift
//  App
//
//  Created by Alexander Skorulis on 26/6/18.
//

enum CharacterAction: String {
    case forage
    case sleep
    case eat //Should really be use item and be under a separate case
}

class ActionController {

    func performCharacterAction(character:CharacterModel,action:CharacterAction) {
        switch(action) {
        case .forage:
            character.time-=10
        case .eat:
            character.satiation+=10
        case .sleep:
            character.time+=10
        }
    }
    
    func getRequirements(action:CharacterAction) -> RequirementList {
        switch(action) {
        case .forage:
            return RequirementList(requirements: [RequirementModel.time(value: 10),RequirementModel.satiation(value: 5)])
        case .eat:
            return RequirementList(requirements: [RequirementModel.time(value: 5)])
        case .sleep:
            return RequirementList.empty()
        }
    }
    
    func hasRequirements(character:CharacterModel,action:CharacterAction) -> Bool {
        let reqs = getRequirements(action: action)
        return hasRequirements(character: character, requirements: reqs)
    }
    
    func hasRequirements(character:CharacterModel,requirements:RequirementList) -> Bool {
        for m in requirements.requirements {
            switch(m.type) {
            case .item:
                return character.inventory.hasItem(name: m.identifier, quantity: m.value)
            case .resource:
                return character.hasResource(name: m.identifier, quantity: m.value)
            case .skill:
                return false //No one has skills yet
            }
        }
        
        return true
    }
    
}
