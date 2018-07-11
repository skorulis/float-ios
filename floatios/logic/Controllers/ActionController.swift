//
//  ActionController.swift
//  App
//
//  Created by Alexander Skorulis on 26/6/18.
//

import SKSwiftLib

class ActionController {

    let ref:ReferenceController
    let dayFinishObservers = ObserverSet<ActionController>()
    
    init(ref:ReferenceController) {
        self.ref = ref
    }
    
    func performAction(character:CharacterModel,action:ActionReferenceModel) {
        let reqs = action.requirements
        takeRequirements(reqs: reqs, character: character)
        switch(action.type) {
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
        case .explore:
            break; //Explore does nothing right now
        }
    }
    
    func hasRequirements(character:CharacterModel,action:ActionReferenceModel) -> Bool {
        let reqs = action.requirements
        return hasRequirements(character: character, requirements: reqs)
    }
    
    func hasRequirements(character:CharacterModel,requirements:[RequirementModel]) -> Bool {
        var result = true
        for m in requirements {
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
    
    func takeRequirements(reqs:[RequirementModel],character:CharacterModel) {
        for m in reqs {
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
    
    func shouldShow(action:ActionReferenceModel,character:CharacterModel) -> Bool {
        let skillReqs = action.requirements.filter { $0.type == .skill}
        return self.hasRequirements(character: character, requirements: skillReqs)
    }
    
}
