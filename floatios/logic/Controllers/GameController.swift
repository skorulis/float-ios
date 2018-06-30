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
    
    init() {
        action = ActionController()
        city = CityController()
        player = PlayerCharacterController(actions: action,city:city)
        npc = NPCController(actions: action,city:city)
        
    }
    
}
