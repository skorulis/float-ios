//
//  MajorStateController.swift
//  floatios
//
//  Created by Alexander Skorulis on 8/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import SKSwiftLib

public class MajorStateController: NSObject {

    let player:PlayerCharacterController
    
    init(player:PlayerCharacterController) {
        self.player = player
    }
    
    let observers = ObserverSet<MajorStateController>()
    
    func playerHasName() -> Bool {
        return self.player.player.base.name.count > 0
    }
    
    func fireStateChange() {
        observers.notify(parameters: self)
    }
    
}
