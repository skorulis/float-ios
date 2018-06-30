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
    
    init() {
        action = ActionController()
        player = PlayerCharacterController(actions: action)
    }
    
}
