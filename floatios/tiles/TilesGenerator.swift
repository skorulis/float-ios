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
    
    func generatePointyEmptyTile(color:UIColor) -> UIImage {
        UIGraphicsBeginImageContext(tileSize)
        let ctx = UIGraphicsGetCurrentContext()!
        
        ctx.move(to: top)
        ctx.addLine(to: topRight)
        ctx.addLine(to: bottomRight)
        ctx.addLine(to: bottom)
        ctx.addLine(to: bottomLeft)
        ctx.addLine(to: topLeft)
        
        ctx.setFillColor(color.cgColor)
        ctx.fillPath()
        
        let img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img!
    }
    
    func generateFlatEmptyTile(color:UIColor) -> UIImage {
        UIGraphicsBeginImageContext(tileSize)
        let ctx = UIGraphicsGetCurrentContext()!
        
        ctx.move(to: CGPoint(x: tileSize.width/2, y: 0))
        ctx.addLine(to: CGPoint(x: tileSize.width, y: tileSize.height/4))
        ctx.addLine(to: CGPoint(x: tileSize.width, y: tileSize.height * 0.75))
        ctx.addLine(to: CGPoint(x: tileSize.width/2, y: tileSize.height))
        ctx.addLine(to: CGPoint(x: 0, y: tileSize.height * 0.75))
        ctx.addLine(to: CGPoint(x: 0, y: tileSize.height/4))
        
        ctx.setFillColor(color.cgColor)
        ctx.fillPath()
        
        let img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img!
    }
    
    func generateWallImage(adj:SKTileAdjacencyMask) -> UIImage {
        UIGraphicsBeginImageContext(tileSize)
        let ctx = UIGraphicsGetCurrentContext()!
        
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
        
        let img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img!
    }
    
    func generateTileDefinition(name:String,color:UIColor) -> SKTileDefinition {
        let img = generatePointyEmptyTile(color:color)
        let def = SKTileDefinition(texture: SKTexture(image: img))
        def.name = name
        return def
    }
    
    func generateWallDefinition(adj:SKTileAdjacencyMask) -> SKTileDefinition {
        let img = generateWallImage(adj: adj)
        let def = SKTileDefinition(texture: SKTexture(image: img))
        def.name = "wall" + adjacencyDescription(adj: adj)
        return def
    }
    
    func generateWallGroup() -> SKTileGroup {
        var rules = [SKTileGroupRule]()
        
        let allCombinations = allAdjacencies()
        for adj in allCombinations {
            let def = generateWallDefinition(adj: adj)
            let rule = SKTileGroupRule(adjacency: adj, tileDefinitions: [def])
            rule.name = def.name
            rules.append(rule)
        }
        let group = SKTileGroup(rules: rules)
        group.name = "wall"
        return group
    }
    
    func dungeonTileSet() -> SKTileSet {
        return SKTileSet(tileGroups: [generateWallGroup()], tileSetType:.hexagonalPointy)
    }
    
    func terrainTileSet() -> SKTileSet {
        let dirt = generateTileDefinition(name: "dirt",color:UIColor.brown)
        let grass = generateTileDefinition(name: "grass",color:UIColor.green)
        let dirtGroup = group(def: dirt)
        let grassGroup = group(def: grass)
        
        return SKTileSet(tileGroups: [dirtGroup,grassGroup], tileSetType: .hexagonalPointy)
    }
    
    static func generateAllTiles() {
        let gen = TilesGenerator(tileSize: CGSize(width: 120, height: 140))
        let dirt = gen.generateTileDefinition(name: "dirt",color:UIColor.brown)
        let green = gen.generateTileDefinition(name: "grass",color:UIColor.green)
        
        let allOptions:[SKTileAdjacencyMask] = [.hexPointyAdjacencyUpperLeft,.hexPointyAdjacencyUpperRight,.hexPointyAdjacencyRight,.hexPointyAdjacencyLowerRight,.hexPointyAdjacencyLowerLeft,.hexPointyAdjacencyLeft]
        
        let decMax = pow(2, allOptions.count)
        let max = (decMax as NSDecimalNumber).intValue
        var allCombinations:[SKTileAdjacencyMask] = []
        
        for i in 0...max {
            var raw:UInt = 0
            for j in 0..<allOptions.count {
                if i & (1 << j) != 0 {
                    raw += allOptions[j].rawValue
                }
            }
            
            allCombinations.append(SKTileAdjacencyMask(rawValue:raw))
        }
        
        for adj in allCombinations {
            let t2 = gen.generateWallDefinition(adj: adj)
            gen.saveTile(def: t2)
        }
        
        gen.saveTile(def: dirt)
        gen.saveTile(def: green)
        
    }
    
    //MARK: helpers
    
    private func group(def:SKTileDefinition) -> SKTileGroup {
        let group = SKTileGroup(tileDefinition: def)
        group.name = def.name
        return group
    }
    
    private func allAdjacencies() -> [SKTileAdjacencyMask] {
        let allOptions:[SKTileAdjacencyMask] = [.hexPointyAdjacencyUpperLeft,.hexPointyAdjacencyUpperRight,.hexPointyAdjacencyRight,.hexPointyAdjacencyLowerRight,.hexPointyAdjacencyLowerLeft,.hexPointyAdjacencyLeft]
        
        let decMax = pow(2, allOptions.count)
        let max = (decMax as NSDecimalNumber).intValue
        var allCombinations:[SKTileAdjacencyMask] = []
        
        for i in 0...max {
            var raw:UInt = 0
            for j in 0..<allOptions.count {
                if i & (1 << j) != 0 {
                    raw += allOptions[j].rawValue
                }
            }
            
            print("raw \(raw)")
            
            allCombinations.append(SKTileAdjacencyMask(rawValue:raw))
        }
        return allCombinations
    }
    
    private func adjacencyDescription(adj:SKTileAdjacencyMask) -> String {
        var ret = ""
        if (adj.contains(.hexPointyAdjacencyUpperLeft)) {
            ret += "ul"
        }
        if (adj.contains(.hexPointyAdjacencyUpperRight)) {
            ret += "ur"
        }
        if (adj.contains(.hexPointyAdjacencyLowerRight)) {
            ret += "lr"
        }
        if (adj.contains(.hexPointyAdjacencyLowerLeft)) {
            ret += "ll"
        }
        if (adj.contains(.hexPointyAdjacencyRight)) {
            ret += "R"
        }
        if (adj.contains(.hexPointyAdjacencyLeft)) {
            ret += "L"
        }
        return ret
    }
    
    private func avg(p1:CGPoint,p2:CGPoint) -> CGPoint {
        return CGPoint(x: (p1.x+p2.x)/2, y: (p1.y+p2.y)/2)
    }
    
}
