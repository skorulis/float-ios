//
//  TerrainReferenceModel.swift
//  floatios
//
//  Created by Alexander Skorulis on 22/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit

public enum TerrainType: String {
    case grass
    case dirt
    case floor
    case water
}

class TerrainReferenceModel: NSObject {

    let type:TerrainType
    let baseColor:UIColor
    var normalTexture:UIImage?
    
    init(type:TerrainType,color:UIColor) {
        self.type = type
        self.baseColor = color
    }
    
}
