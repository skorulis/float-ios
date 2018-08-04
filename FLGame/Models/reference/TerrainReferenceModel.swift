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

public class TerrainReferenceModel {

    public let type:TerrainType
    public let baseColor:UIColor
    public var normalTexture:UIImage?
    
    public init(type:TerrainType,color:UIColor) {
        self.type = type
        self.baseColor = color
    }
    
}
