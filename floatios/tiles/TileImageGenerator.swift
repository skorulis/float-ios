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

    func generatePointyEmptyTile(color:UIColor) -> UIImage {
        let ctx = newContext()
        
        ctx.move(to: top)
        ctx.addLine(to: topRight)
        ctx.addLine(to: bottomRight)
        ctx.addLine(to: bottom)
        ctx.addLine(to: bottomLeft)
        ctx.addLine(to: topLeft)
        
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
            ctx.move(to: centre)
            ctx.addLine(to: avg(p1: top, p2: topLeft))
        }
        if (adj.contains(.hexPointyAdjacencyUpperRight)) {
            ctx.move(to: centre)
            ctx.addLine(to: avg(p1: top, p2: topRight))
        }
        if (adj.contains(.hexPointyAdjacencyLowerRight)) {
            ctx.move(to: centre)
            ctx.addLine(to: avg(p1: bottom, p2: bottomRight))
        }
        if (adj.contains(.hexPointyAdjacencyLowerLeft)) {
            ctx.move(to: centre)
            ctx.addLine(to: avg(p1: bottom, p2: bottomLeft))
        }
        if (adj.contains(.hexPointyAdjacencyRight)) {
            ctx.move(to: centre)
            ctx.addLine(to: right)
        }
        if (adj.contains(.hexPointyAdjacencyLeft)) {
            ctx.move(to: centre)
            ctx.addLine(to: left)
        }
        
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
