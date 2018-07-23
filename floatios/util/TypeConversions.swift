//
//  TypeConversions.swift
//  floatios
//
//  Created by Alexander Skorulis on 23/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import GameplayKit

extension vector_int2 {
    
    var point: CGPoint {
        return CGPoint(x: Int(self.x), y: Int(self.y))
    }
    
}

