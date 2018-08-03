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
    
    func topHex() -> UIImage {
        let ctx = newContext(textureSize)
        let points = (0..<6).map { math.regularHexUV(index: $0)}
        ctx.move(to: points[0])
        for i in 1..<6 {
            ctx.addLine(to: points[i])
        }
        ctx.closePath()
        ctx.setFillColor(UIColor.brown.cgColor)
        ctx.fillPath()
        
        return finishContext()
    }
    
    func spikeySide() -> UIImage {
        let ctx = newContext(textureSize)
        let spikeCount = 3
        let xMov = textureSize.width / CGFloat(spikeCount * 2)
        ctx.setFillColor(UIColor.lightGray.cgColor)
        ctx.fill(CGRect(origin: .zero, size: textureSize))
        
        
        let spikeTop = textureSize.height / 8
        let spikeBottom = textureSize.height / 4
        
        ctx.move(to: CGPoint(x: 0, y: spikeBottom))
        for i in 0...spikeCount {
            let p1 = CGPoint(x: xMov*2*CGFloat(i), y: spikeBottom)
            let p2 = CGPoint(x: xMov*(2*CGFloat(i) + 1), y: spikeTop)
            ctx.addLine(to: p1)
            ctx.addLine(to: p2)
        }
        ctx.addLine(to: CGPoint(x: textureSize.width, y: 0))
        ctx.addLine(to: CGPoint(x: 0, y: 0))
        ctx.closePath()
        ctx.setFillColor(UIColor.brown.cgColor)
        ctx.fillPath()
        
        return finishContext()
    }
    
    class func generateAllImages() {
        let gen = HexTextureGenerator()
        
        gen.saveImage(name: "hex1", image: gen.topHex())
        gen.saveImage(name: "spike1", image: gen.spikeySide())
    }
    
    //MARK: Helpers
    
    var textureSize: CGSize {
        return CGSize(width: math.baseSize, height: math.baseSize)
    }
    
    
    
}
