//
//  ActionController.swift
//  App
//
//  Created by Alexander Skorulis on 26/6/18.
//

import SKSwiftLib

enum CharacterAction: String {
    case forage //Find food
    case mine //Find minerals
    case lumberjack //Get wood
    case sleep
    case eat //Should really be use item and be under a separate case
}

class ActionController {

    let ref:ReferenceController
    let dayFinishObservers = ObserverSet<ActionController>()
    
    init(ref:ReferenceController) {
        self.ref = ref
    }
    
    func performCharacterAction(character:CharacterModel,action:CharacterAction) {
        let reqs = getRequirements(action: action);
        takeRequirements(reqs: reqs, character: character)
        switch(action) {
        case .forage:
            let item = ItemModel(ref: ref.getItem(name: "Food"))
            character.inventory.add(item: item)
        case .mine:
            character.inventory.add(item: ItemModel(ref: ref.getItem(name: "Minerals")))
        case .lumberjack:
            character.inventory.add(item: ItemModel(ref: ref.getItem(name: "Wood")))
        case .eat:
            character.satiation += 20
        case .sleep:
            dayFinishObservers.notify(parameters: self)
        }
    }
    
    func getRequirements(action:CharacterAction) -> RequirementList {
        switch(action) {
        case .forage:
            return RequirementList(requirements: [RequirementModel.time(value: 10),RequirementModel.satiation(value: 5)])
        case .mine:
            return RequirementList(requirements: [RequirementModel.time(value: 20),RequirementModel.satiation(value: 10)])
        case .lumberjack:
            return RequirementList(requirements: [RequirementModel.time(value: 20),RequirementModel.satiation(value: 10)])
        case .eat:
            return RequirementList(requirements: [RequirementModel.time(value: 5),RequirementModel.item(name: "Food", value: 1)])
        case .sleep:
            return RequirementList.empty()
        }
    }
    
    func hasRequirements(character:CharacterModel,action:CharacterAction) -> Bool {
        let reqs = getRequirements(action: action)
        return hasRequirements(character: character, requirements: reqs)
    }
    
    func hasRequirements(character:CharacterModel,requirements:RequirementList) -> Bool {
        var result = true
        for m in requirements.requirements {
            switch(m.type) {
            case .item:
                result = result && character.inventory.hasItem(name: m.identifier, quantity: m.value)
            case .resource:
                result = result && character.hasResource(name: m.identifier, quantity: m.value)
            case .skill:
                return false //No one has skills yet
            }
        }
        
        return result
    }
    
    func takeRequirements(reqs:RequirementList,character:CharacterModel) {
        for m in reqs.requirements {
            switch(m.type) {
            case .item:
                character.inventory.consumeItem(name: m.identifier, quantity: m.value)
            case .resource:
                character.takeResource(name: m.identifier, quantity: m.value)
            case .skill:
                break//Nothing to be done
            }
        }
    }
    
    func endDay(character:CharacterModel) {
        character.time.setToMax()
        character.satiation.add(5) //Make sure you can't get stuck, may remove later
        character.ether += 10
    }
    
}
