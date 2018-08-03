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
    let hexGeometry:SCNGeometry
    var terrain:[SCNNode] = []
    
    init(size:vector_int2) {
        self.size = size
        let game = GameController.instance
        let ref = game.reference.getTerrain(type: .grass)
        
        hexGeometry = HexGeometry(store:GameController.instance.geometry).getGeometry(ref: ref)
        super.init()
        
        for i in 0..<size.y {
            let isOdd = i % 2 == 1
            let offsetX:Float = isOdd ? 1.0 : 0
            let rowY = Float(i) * 1.8
            for j in 0..<size.x {
                let n1 = SCNNode(geometry: hexGeometry)
                n1.position = SCNVector3(Float(j*2) + offsetX,0,rowY)
                self.addChildNode(n1)
            }
        }
    }
    
    func buildTerrain() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
