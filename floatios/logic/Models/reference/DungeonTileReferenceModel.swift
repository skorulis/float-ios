//
//  DungeonTileReferenceModel.swift
//  floatios
//
//  Created by Alexander Skorulis on 21/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit

public enum DungeonTileType:String {
    case wall = "wall"
    case stairsUp = "stair-up"
    case stairsDown = "stair-down"
}

enum DungeonAction: String {
    case goUp
    case goDown
}

struct DungeonTileReferenceModel {

    let type:DungeonTileType
    let canPass:Bool
    let actions:[DungeonAction]
    
    init(type:DungeonTileType,canPass:Bool,actions:[DungeonAction] = []) {
        self.type = type
        self.canPass = canPass
        self.actions = actions
    }
    
}
