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
    public let blockHeight:Float
    
    public init(dungeon:DungeonModel,gen:HexGeometry) {
        self.dungeon = dungeon
        self.size = dungeon.size
        
        blockHeight = Float(gen.height())
        
        
        super.init()
        
        for y in 0..<size.y {
            for x in 0..<size.x {
                let dungeonNode = dungeon.nodeAt(x: Int(x), y: Int(y))!
                if dungeonNode.terrain.type == .void {
                    continue
                }
                let terrain = dungeonNode.terrain
                let hexGeometry = gen.bevelHex(ref: terrain)
                let sides = gen.sideGeometry(height:gen.height(),ref:terrain)
                
                let parentNode = SCNNode()
                
                parentNode.position = localPosition(at: vector_int2(x,y))
                let n1 = SCNNode(geometry: hexGeometry)
                let n2 = SCNNode(geometry: sides)
                parentNode.addChildNode(n1)
                parentNode.addChildNode(n2)
                
                self.addChildNode(parentNode)
            }
        }
    }
    
    //Return the 3D coordinates of the tile at the grid index
    public func localPosition(at:vector_int2) -> SCNVector3 {
        let dungeonNode = dungeon.nodeAt(vec: at)
        let gridMult:Float = 0.9
        let yMult:Float = 1.75 * gridMult
        let xMult:Float = 2.0 * gridMult
        
        let isOdd = at.y % 2 == 1
        let offsetX:Float = isOdd ? gridMult : 0
        let rowY = Float(at.y) * yMult
        let yPos = Float(dungeonNode?.yOffset ?? 0) * 0.5
        
        return SCNVector3(Float(at.x)*xMult + offsetX,yPos,rowY)
    }
    
    //Returns the coordinates of the top of the tile
    public func topPosition(at:vector_int2) -> SCNVector3 {
        let mid = localPosition(at: at)
        return SCNVector3(mid.x,mid.y+blockHeight/2,mid.z)
    }
    
    public func buildTerrain() {
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
