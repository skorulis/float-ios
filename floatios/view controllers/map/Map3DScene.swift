//
//  Map3DScene.swift
//  floatios
//
//  Created by Alexander Skorulis on 2/8/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import SceneKit

class Map3DScene: SCNScene {

    var mapGrid:Hex3DMapNode!
    
    let dungeon:DungeonModel
    
    init(dungeon:DungeonModel) {
        self.dungeon = dungeon
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
        
        let imageNames = ["Daylight Box_Right","Daylight Box_Left","Daylight Box_Top","Daylight Box_Bottom","Daylight Box_Back","Daylight Box_Front"]
        
        self.background.contents = imageNames.map { UIImage(named: $0)}
        
        mapGrid = self.makeMap()
        self.rootNode.addChildNode(mapGrid)
    }
    
    func makeMap() -> Hex3DMapNode {
        let mapGrid = Hex3DMapNode(dungeon: dungeon)
        let sphere = mapGrid.boundingSphere
        mapGrid.position = SCNVector3(-sphere.center.x,0,-sphere.center.z)
        return mapGrid
    }
    
}
