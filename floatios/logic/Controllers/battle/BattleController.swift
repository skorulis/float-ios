//
//  BattleController.swift
//  floatios
//
//  Created by Alexander Skorulis on 29/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit

class BattleController: NSObject {

    func performAttack(from:CharacterModel,to:MonsterEntity) {
        from.health -= 10
    }
    
}
