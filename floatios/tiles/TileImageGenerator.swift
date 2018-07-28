//
//  TileImageGenerator.swift
//  floatios
//
//  Created by Alexander Skorulis on 21/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SpriteKit

class TileImageGenerator: NSObject {
    
    let tileSize:CGSize
    let math:HexGridMath
    
    init(tileSize:CGSize) {
        self.tileSize = tileSize
        self.math = HexGridMath(tileSize: tileSize)
    }

    func generatePointyEmptyTile(color:UIColor) -> UIImage {
        let ctx = newContext()
        
        ctx.move(to: math.top)
        ctx.addLine(to: math.topRight)
        ctx.addLine(to: math.bottomRight)
        ctx.addLine(to: math.bottom)
        ctx.addLine(to: math.bottomLeft)
        ctx.addLine(to: math.topLeft)
        
        ctx.setFillColor(color.cgColor)
        ctx.fillPath()
        
        return finishContext()
    }
    
    func generateFlatEmptyTile(color:UIColor) -> UIImage {
        let ctx = newContext()
        
        ctx.move(to: CGPoint(x: tileSize.width/2, y: 0))
        ctx.addLine(to: CGPoint(x: tileSize.width, y: tileSize.height/4))
        ctx.addLine(to: CGPoint(x: tileSize.width, y: tileSize.height * 0.75))
        ctx.addLine(to: CGPoint(x: tileSize.width/2, y: tileSize.height))
        ctx.addLine(to: CGPoint(x: 0, y: tileSize.height * 0.75))
        ctx.addLine(to: CGPoint(x: 0, y: tileSize.height/4))
        
        ctx.setFillColor(color.cgColor)
        ctx.fillPath()
        
        return finishContext()
    }
    
    func generateIconTile(tileContext:TileGenContext) -> UIImage {
        return tileContext.icon!.image(with: tileSize)
    }
    
    func generateWallImage(adj:SKTileAdjacencyMask) -> UIImage {
        let ctx = newContext()
        
        ctx.setStrokeColor(UIColor.purple.cgColor)
        ctx.setLineWidth(30)
        
        if (adj.contains(.hexPointyAdjacencyUpperLeft)) {
            ctx.move(to: math.centre)
            ctx.addLine(to: avg(p1: math.top, p2: math.topLeft))
        }
        if (adj.contains(.hexPointyAdjacencyUpperRight)) {
            ctx.move(to: math.centre)
            ctx.addLine(to: avg(p1: math.top, p2: math.topRight))
        }
        if (adj.contains(.hexPointyAdjacencyLowerRight)) {
            ctx.move(to: math.centre)
            ctx.addLine(to: avg(p1: math.bottom, p2: math.bottomRight))
        }
        if (adj.contains(.hexPointyAdjacencyLowerLeft)) {
            ctx.move(to: math.centre)
            ctx.addLine(to: avg(p1: math.bottom, p2: math.bottomLeft))
        }
        if (adj.contains(.hexPointyAdjacencyRight)) {
            ctx.move(to: math.centre)
            ctx.addLine(to: math.right)
        }
        if (adj.contains(.hexPointyAdjacencyLeft)) {
            ctx.move(to: math.centre)
            ctx.addLine(to: math.left)
        }
        
        ctx.strokePath()
        
        return finishContext()
    }
    
    func generateBattleDivider() -> UIImage {
        let ctx = newContext()
        
        let points = [math.topRight,math.top,math.topLeft,math.bottomLeft,math.bottom,math.bottomRight]
        
        ctx.setStrokeColor(UIColor.black.cgColor)
        ctx.setLineWidth(1)
        
        ctx.move(to: points[0])
        
        
        for p in points {
            let halfway = avg(p1: math.centre, p2: p)
            ctx.addLine(to: halfway)
            ctx.addLine(to: p)
            ctx.move(to: halfway)
        }
        let final = avg(p1: math.centre, p2: math.topRight)
        ctx.addLine(to: final)
        
        ctx.strokePath()
        
        return finishContext()
    }
    
    //MARK: Helpers
    
    private func finishContext() -> UIImage {
        let img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img!
    }
    
    private func newContext() -> CGContext {
        UIGraphicsBeginImageContext(tileSize)
        return UIGraphicsGetCurrentContext()!
    }
    
    private func avg(p1:CGPoint,p2:CGPoint) -> CGPoint {
        return CGPoint(x: (p1.x+p2.x)/2, y: (p1.y+p2.y)/2)
    }
    
}
