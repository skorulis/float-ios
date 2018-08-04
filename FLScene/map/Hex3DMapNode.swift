//
//  Hex3DMapNode.swift
//  floatios
//
//  Created by Alexander Skorulis on 2/8/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import SceneKit
import FLGame

public class Hex3DMapNode: SCNNode {

    public let dungeon:DungeonModel
    public let size:vector_int2
    public var terrain:[SCNNode] = []
    
    public init(dungeon:DungeonModel) {
        self.dungeon = dungeon
        self.size = dungeon.size
        
        let store = GeometryStore()
        let gen = HexGeometry(store:store)
        
        let sides = gen.sideGeometry()
        super.init()
        
        let gridMult:Float = 0.9
        let yMult:Float = 1.75 * gridMult
        let xMult:Float = 2.0 * gridMult
        
        for y in 0..<size.y {
            let isOdd = y % 2 == 1
            let offsetX:Float = isOdd ? gridMult : 0
            let rowY = Float(y) * yMult
            for x in 0..<size.x {
                let dungeonNode = dungeon.nodeAt(x: Int(x), y: Int(y))!
                if dungeonNode.terrain.type == .void {
                    continue
                }
                let terrain = dungeonNode.terrain
                let hexGeometry = gen.hexGeometry(ref: terrain)
                
                let parentNode = SCNNode()
                let yPos = Float(dungeonNode.yOffset) * 0.5
                
                parentNode.position = SCNVector3(Float(x)*xMult + offsetX,yPos,rowY)
                let n1 = SCNNode(geometry: hexGeometry)
                let n2 = SCNNode(geometry: sides)
                parentNode.addChildNode(n1)
                parentNode.addChildNode(n2)
                
                self.addChildNode(parentNode)
            }
        }
    }
    
    public func buildTerrain() {
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
