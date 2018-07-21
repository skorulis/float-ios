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
import FontAwesomeKit

class TilesGenerator: NSObject {

    let tileSize:CGSize
    let rootDir:String = "tiles"
    let imageGen:TileImageGenerator
    
    var fontSize:CGFloat {
        return tileSize.height/2
    }
    
    init(tileSize:CGSize) {
        self.tileSize = tileSize
        self.imageGen = TileImageGenerator(tileSize: tileSize)
        
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
    
    func simpleGroup(context:TileGenContext) -> SKTileGroup {
        let img = imageGen.generateIconTile(tileContext: context)
        let def = SKTileDefinition(texture: SKTexture(image: img))
        def.name = context.name
        let group = SKTileGroup(tileDefinition: def)
        group.name = def.name
        return group
    }
    
    func generateTileDefinition(name:String,color:UIColor) -> SKTileDefinition {
        let img = imageGen.generatePointyEmptyTile(color:color)
        let def = SKTileDefinition(texture: SKTexture(image: img))
        def.name = name
        return def
    }
    
    func generateWallDefinition(adj:SKTileAdjacencyMask) -> SKTileDefinition {
        let img = imageGen.generateWallImage(adj: adj)
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
        let stairUp = simpleGroup(context: TileGenContext(name: "stair-up", color: nil, icon: FAKFontAwesome.arrowCircleUpIcon(withSize: fontSize)))
        let stairDown = simpleGroup(context: TileGenContext(name: "stair-down", color: nil, icon: FAKFontAwesome.arrowCircleDownIcon(withSize: fontSize)))
        
        return SKTileSet(tileGroups: [generateWallGroup(),stairUp,stairDown], tileSetType:.hexagonalPointy)
    }
    
    func terrainTileSet() -> SKTileSet {
        let dirt = generateTileDefinition(name: "dirt",color:UIColor.brown)
        let grass = generateTileDefinition(name: "grass",color:UIColor.green)
        let floor = generateTileDefinition(name: "floor",color:UIColor.darkGray)
        let dirtGroup = group(def: dirt)
        let grassGroup = group(def: grass)
        
        
        return SKTileSet(tileGroups: [dirtGroup,grassGroup,group(def:floor)], tileSetType: .hexagonalPointy)
    }
    
    static func generateAllTiles() {
        let gen = TilesGenerator(tileSize: CGSize(width: 120, height: 140))
        let dungeonSet = gen.dungeonTileSet()
        let terrainSet = gen.terrainTileSet()
        
        gen.dumpTileSet(set: dungeonSet)
        gen.dumpTileSet(set: terrainSet)
        
    }
    
    func dumpTileSet(set:SKTileSet) {
        for group in set.tileGroups {
            for rule in group.rules {
                for def in rule.tileDefinitions {
                    saveTile(def:def)
                }
            }
        }
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
    
    
    
}
