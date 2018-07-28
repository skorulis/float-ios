//
//  HexGridMath.swift
//  floatios
//
//  Created by Alexander Skorulis on 28/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import GameplayKit

class HexGridMath {
    
    let tileSize:CGSize
    
    var centre:CGPoint {
        return CGPoint(x: tileSize.width/2, y: tileSize.height/2)
    }
    var right:CGPoint {
        return CGPoint(x: tileSize.width, y: tileSize.height/2)
    }
    var left:CGPoint {
        return CGPoint(x: 0, y: tileSize.height/2)
    }
    var top:CGPoint {
        return CGPoint(x: tileSize.width/2, y: 0)
    }
    var bottom:CGPoint {
        return CGPoint(x: tileSize.width/2, y: tileSize.height)
    }
    var topLeft:CGPoint {
        return CGPoint(x: 0, y: tileSize.height/4)
    }
    var topRight:CGPoint {
        return CGPoint(x: tileSize.width, y: tileSize.height/4)
    }
    var bottomLeft:CGPoint {
        return CGPoint(x: 0, y: tileSize.height*0.75)
    }
    var bottomRight:CGPoint {
        return CGPoint(x: tileSize.width, y: tileSize.height*0.75)
    }
    
    init(tileSize:CGSize) {
        self.tileSize = tileSize
        
    }
    
}

extension vector_int2 {
    var hexOddRow:Bool {
        return y % 2 == 1
    }
    
    var hexLeft:vector_int2 {
        return vector_int2(x-1,y)
    }
    var hexRight:vector_int2 {
        return vector_int2(x+1,y)
    }
    var hexBottomRight:vector_int2 {
        return hexOddRow ? vector_int2(x + 1, y + 1) : vector_int2(x, y + 1)
    }
    var hexBottomLeft:vector_int2 {
        return hexOddRow ? vector_int2(x, y + 1) : vector_int2(x - 1, y + 1)
    }
    var hexTopRight:vector_int2 {
        return hexOddRow ? vector_int2(x + 1, y - 1) : vector_int2(x, y - 1)
    }
    var hexTopLeft:vector_int2 {
        return hexOddRow ? vector_int2(x, y - 1) : vector_int2(x - 1, y - 1)
    }
    
    var hexSurrounding:[vector_int2] {
        return [hexLeft,hexRight,hexBottomLeft,hexBottomRight,hexTopRight,hexTopLeft]
    }
}
