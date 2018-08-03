//
//  Hex3DMath.swift
//  floatios
//
//  Created by Alexander Skorulis on 3/8/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit

class Hex3DMath: NSObject {

    let baseSize:CGFloat
    
    init(baseSize:CGFloat) {
        self.baseSize = baseSize
    }
    
    func regularHexPoint(index:Int) -> CGPoint {
        let angle = (CGFloat(index) * CGFloat.pi / 3) - CGFloat.pi/2
        return CGPoint(angle: angle, length: baseSize)
    }
    
    func regularHexUV(index:Int) -> CGPoint {
        var point = regularHexPoint(index: index)
        point.x = (point.x + baseSize) / 2;
        point.y = (point.y + baseSize) / 2;
        return point
    }
    
}
