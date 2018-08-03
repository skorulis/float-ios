//
//  HexTextureGenerator.swift
//  floatios
//
//  Created by Alexander Skorulis on 3/8/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit

class HexTextureGenerator: ImageGen {

    let math:Hex3DMath
    
    init() {
        math = Hex3DMath(baseSize: 128)
        super.init(rootDir: "3d")
    }
    
    func topGrid() -> UIImage {
        let ctx = newContext(textureSize)
        let points = (0..<6).map { math.regularHexPoint(index: $0)}
        ctx.move(to: points[0])
        for i in 1..<6 {
            ctx.addLine(to: points[i])
        }
        ctx.closePath()
        ctx.setFillColor(UIColor.brown.cgColor)
        ctx.fillPath()
        
        return finishContext()
    }
    
    class func generateAllImages() {
        let gen = HexTextureGenerator()
        let t1 = gen.topGrid()
        
        gen.saveImage(name: "hex1.png", image: t1)
    }
    
    //MARK: Helpers
    
    var textureSize: CGSize {
        return CGSize(width: math.baseSize*2, height: math.baseSize*2)
    }
    
    
    
}
