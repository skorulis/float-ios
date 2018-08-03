//
//  Hex3DMapNode.swift
//  floatios
//
//  Created by Alexander Skorulis on 2/8/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import SceneKit

class Hex3DMapNode: SCNNode {

    let size:vector_int2
    var terrain:[SCNNode] = []
    
    init(size:vector_int2) {
        self.size = size
        let game = GameController.instance
        let ref = game.reference.getTerrain(type: .grass)
        
        let gen = HexGeometry(store:GameController.instance.geometry)
        
        let hexGeometry = gen.hexGeometry(ref: ref)
        let sides = gen.sideGeometry()
        super.init()
        
        for i in 0..<size.y {
            let isOdd = i % 2 == 1
            let offsetX:Float = isOdd ? 1.0 : 0
            let rowY = Float(i) * 1.8
            for j in 0..<size.x {
                let parentNode = SCNNode()
                parentNode.position = SCNVector3(Float(j*2) + offsetX,0,rowY)
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
