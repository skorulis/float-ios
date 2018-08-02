//
//  Map3DScene.swift
//  floatios
//
//  Created by Alexander Skorulis on 2/8/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import SceneKit

class Map3DScene: SCNScene {

    //let mapGrid:Hex3DMapNode
    
    override init() {
        //mapGrid = Hex3DMapNode(size: vector_int2(2,2))
        super.init()
        self.buildScene()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildScene() {
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        rootNode.addChildNode(ambientLightNode)
        
        //let mapGrid = Hex3DMapNode(size: vector_int2(2,2))
        //mapGrid.position = SCNVector3(0,0,15)
        //rootNode.addChildNode(mapGrid)
    }
    
}
