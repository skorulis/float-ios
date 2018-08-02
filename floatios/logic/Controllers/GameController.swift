//
//  GameController.swift
//  App
//
//  Created by Alexander Skorulis on 26/6/18.
//


class GameController {

    static let instance = GameController()
    
    let action:ActionController;
    let player:PlayerCharacterController;
    let city:CityController;
    let npc:NPCController
    let reference:ReferenceController
    let majorState:MajorStateController
    let battle:BattleController
    
    init() {
        reference = ReferenceController()
        action = ActionController(ref:reference)
        city = CityController()
        player = PlayerCharacterController(actions: action,city:city)
        npc = NPCController(actions: action,city:city,ref:reference)
        
        majorState = MajorStateController(player:player)
        battle = BattleController()
        
        action.dayFinishObservers.add(object:self) {[unowned self] (controller) in
            self.city.dayFinished()
            self.player.dayFinished()
            self.npc.dayFinished()
        }
        
    }
    
}
