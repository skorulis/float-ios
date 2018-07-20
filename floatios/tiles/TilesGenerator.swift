//
//  TilesGenerator.swift
//  floatios
//
//  Created by Alexander Skorulis on 20/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKSwiftLib
import SpriteKit

class TilesGenerator: NSObject {

    let tileSize:CGSize
    let rootDir:String = "tiles"
    
    init(tileSize:CGSize) {
        self.tileSize = tileSize
        
        let path = PathHelper.documentsDirectoryPath() + rootDir
        do {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: false, attributes: nil)
        } catch {
            
        }
        
        print("Writing tiles to " + path)
    }
    
    func saveTile(def:SKTileDefinition) {
        let cgImage = def.textures.first!.cgImage()
        let data = UIImagePNGRepresentation(UIImage(cgImage: cgImage))
        let fileName = def.name! + ".png"
        let fileURL = PathHelper.documentsDirectory().appendingPathComponent(rootDir).appendingPathComponent(fileName)
        do {
            try data?.write(to: fileURL)
        } catch {}
        
    }
    
    func generateEmptyTile() -> UIImage {
        UIGraphicsBeginImageContext(tileSize)
        let ctx = UIGraphicsGetCurrentContext()!
        
        ctx.move(to: CGPoint(x: tileSize.width/2, y: 0))
        ctx.addLine(to: CGPoint(x: tileSize.width, y: tileSize.height/4))
        ctx.addLine(to: CGPoint(x: tileSize.width, y: tileSize.height * 0.75))
        ctx.addLine(to: CGPoint(x: tileSize.width/2, y: tileSize.height))
        ctx.addLine(to: CGPoint(x: 0, y: tileSize.height * 0.75))
        ctx.addLine(to: CGPoint(x: 0, y: tileSize.height/4))
        
        ctx.setFillColor(UIColor.brown.cgColor)
        ctx.fillPath()
        
        let img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img!
    }
    
    func generateWallImage(adj:SKTileAdjacencyMask) -> UIImage {
        UIGraphicsBeginImageContext(tileSize)
        let ctx = UIGraphicsGetCurrentContext()!
        
        ctx.setStrokeColor(UIColor.lightGray.cgColor)
        ctx.setLineWidth(10)
        ctx.move(to: CGPoint(x: 0, y: tileSize.height/2))
        ctx.addLine(to: CGPoint(x:tileSize.width,y:tileSize.height/2))
        ctx.strokePath()
        
        let img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img!
    }
    
    func generateTileDefinition(name:String) -> SKTileDefinition {
        let img = generateEmptyTile()
        let def = SKTileDefinition(texture: SKTexture(image: img))
        def.name = name
        return def
    }
    
    func generateWallDefinition(adj:SKTileAdjacencyMask) -> SKTileDefinition {
        let img = generateWallImage(adj: adj)
        let def = SKTileDefinition(texture: SKTexture(image: img))
        def.name = "wall"
        return def
    }
    
    static func generateAllTiles() {
        let gen = TilesGenerator(tileSize: CGSize(width: 60, height: 70))
        let tile = gen.generateTileDefinition(name: "test")
        let t2 = gen.generateWallDefinition(adj: .adjacencyAll)
        gen.saveTile(def: tile)
        gen.saveTile(def: t2)
    }
    
}
