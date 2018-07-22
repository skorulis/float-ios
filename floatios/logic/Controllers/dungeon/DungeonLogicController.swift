//
//  DungeonLogicController.swift
//  floatios
//
//  Created by Alexander Skorulis on 21/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit

class DungeonLogicController: NSObject {

    let dungeon:DungeonModel
    let ref:ReferenceController
    
    init(dungeon:DungeonModel,ref:ReferenceController) {
        self.dungeon = dungeon
        self.ref = ref
    }
    
    func getActions(at point:CGPoint) -> [DungeonAction] {
        guard let type = dungeon.fixture(at: point) else {
            return []
        }
        let fixture = ref.getDungeonTile(type: type)
        return fixture.actions
    }
}
