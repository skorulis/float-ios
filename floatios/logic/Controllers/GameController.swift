//
//  GameController.swift
//  App
//
//  Created by Alexander Skorulis on 26/6/18.
//


class GameController {

    static let instance = GameController()
    
    let action:ActionController = ActionController()
    let player:PlayerCharacterController = PlayerCharacterController()
    
}
