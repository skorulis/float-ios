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

struct DungeonTileReferenceModel {

    let type:DungeonTileType
    let canPass:Bool
    
    
}
