//
//  Hex3DMapNode.swift
//  floatios
//
//  Created by Alexander Skorulis on 2/8/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import SceneKit

class Hex3DMapNode: SCNNode {

    let dungeon:DungeonModel
    let size:vector_int2
    var terrain:[SCNNode] = []
    
    init(dungeon:DungeonModel) {
        self.dungeon = dungeon
        self.size = dungeon.size
        
        let store = GeometryStore()
        let gen = HexGeometry(store:store)
        
        let sides = gen.sideGeometry()
        super.init()
        
        for y in 0..<size.y {
            let isOdd = y % 2 == 1
            let offsetX:Float = isOdd ? 1.0 : 0
            let rowY = Float(y) * 1.8
            for x in 0..<size.x {
                let dungeonNode = dungeon.nodeAt(x: Int(x), y: Int(y))!
                let terrain = dungeonNode.terrain
                let hexGeometry = gen.hexGeometry(ref: terrain)
                
                let parentNode = SCNNode()
                parentNode.position = SCNVector3(Float(x*2) + offsetX,0,rowY)
                let n1 = SCNNode(geometry: hexGeometry)
                let n2 = SCNNode(geometry: sides)
                parentNode.addChildNode(n1)
                parentNode.addChildNode(n2)
                
                self.addChildNode(parentNode)
            }
        }
    }
    
    func buildTerrain() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
