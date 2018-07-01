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

    let ref:ReferenceController
    
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
        case .eat:
            character.satiation += 20
        case .sleep:
            character.time.setToMax()
        }
    }
    
    func getRequirements(action:CharacterAction) -> RequirementList {
        switch(action) {
        case .forage:
            return RequirementList(requirements: [RequirementModel.time(value: 10),RequirementModel.satiation(value: 5)])
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
    
}
