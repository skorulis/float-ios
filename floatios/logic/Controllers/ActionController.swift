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
    
}
