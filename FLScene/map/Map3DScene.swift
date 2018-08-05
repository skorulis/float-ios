//
//  Map3DScene.swift
//  floatios
//
//  Created by Alexander Skorulis on 2/8/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import SceneKit
import FLGame
import SCNMathExtensions

public class Map3DScene: SCNScene {

    public var mapGrid:Hex3DMapNode!
    
    public let dungeon:DungeonModel
    
    public init(dungeon:DungeonModel) {
        self.dungeon = dungeon
        super.init()
        self.buildScene()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func buildScene() {
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
        
        let skyBox = MDLSkyCubeTexture(name: nil, channelEncoding: MDLTextureChannelEncoding.uInt8,
                                       textureDimensions: [Int32(160), Int32(160)], turbidity: 0.4, sunElevation: 0.7, upperAtmosphereScattering: 0.2, groundAlbedo: 2)
        skyBox.groundColor = UIColor.brown.cgColor
        
        self.background.contents = skyBox.imageFromTexture()?.takeUnretainedValue()

        
        mapGrid = self.makeMap()
        self.rootNode.addChildNode(mapGrid)
        
        let act1 = SCNAction.moveBy(x: 0, y: -0.5, z: 0, duration: 5)
        let act2 = SCNAction.moveBy(x: 0, y: 0.5, z: 0, duration: 5)
        mapGrid.runAction(SCNAction.repeatForever(SCNAction.sequence([act1,act2])))
        
        addSpike(at: SCNVector3(10,0,8))
        addSpike(at: SCNVector3(-10,0,-8))
        
        let plane = SCNPlane(width: 1, height: 2)
        plane.firstMaterial?.diffuse.contents = UIImage(named: "alienPink")
        
        let planeNode = SCNNode(geometry:plane)
        let constraint = SCNBillboardConstraint()
        constraint.freeAxes = SCNBillboardAxis.Y
        planeNode.constraints = [constraint]
        
        planeNode.position = mapGrid.topPosition(at: vector2(2,2)) + SCNVector3(0,1,0)
        mapGrid.addChildNode(planeNode)
    }
    
    private func addSpike(at:SCNVector3) {
        let material = SCNMaterial()
        
        material.diffuse.contents = UIColor.brown
        //material.normal.contents = UIImage(named: "sandstonecliff-normal")
        material.lightingModel = .physicallyBased
        
        let geom = SCNPyramid(width: 2, height: 10, length: 2)
        geom.firstMaterial = material
        let node = SCNNode(geometry: geom)
        self.rootNode.addChildNode(node)
        node.position = at
        node.position.y = -10
    }
    
    public func makeMap() -> Hex3DMapNode {
        let mapGrid = Hex3DMapNode(dungeon: dungeon)
        let sphere = mapGrid.boundingSphere
        mapGrid.position = SCNVector3(-sphere.center.x,0,-sphere.center.z)
        return mapGrid
    }
    
    class func collada2SCNNode(filepath:String) -> SCNNode {
        
        let node = SCNNode()
        let scene = SCNScene(named: filepath)
        let nodeArray = scene!.rootNode.childNodes
        
        for childNode in nodeArray {
            
            node.addChildNode(childNode as SCNNode)
            
        }
        
        return node
        
    }
    
}
