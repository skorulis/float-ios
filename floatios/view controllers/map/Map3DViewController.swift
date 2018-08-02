//
//  Map3DViewController.swift
//  floatios
//
//  Created by Alexander Skorulis on 2/8/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SceneKit
import SnapKit

class Map3DViewController: UIViewController {

    let scene:Map3DScene
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.scene = Map3DScene();
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = "Map"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let sceneView = SCNView(frame: self.view.bounds)
        self.view.addSubview(sceneView)
        sceneView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        sceneView.scene = self.scene
        sceneView.allowsCameraControl = true
        sceneView.showsStatistics = true
        sceneView.backgroundColor = UIColor.black
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        
        //let spin = SCNAction.rotateBy(x: 0.4, y: 0, z: 0.1, duration: 0.25)
        //scene.mapGrid.runAction(SCNAction.repeatForever(spin))
        //scene.mapGrid.removeFromParentNode()
        
        
        let mapGrid = Hex3DMapNode(size: vector_int2(3,3))
        mapGrid.position = SCNVector3(0,-6,0)
        scene.rootNode.addChildNode(mapGrid)
        
        /*let hexGeom = HexGeometry()
        let geom = hexGeom.getGeometry()
        let node = SCNNode(geometry: geom)
        scene.rootNode.addChildNode(node)
        
        let spin2 = SCNAction.rotateBy(x: 0.4, y: 0, z: 0.1, duration: 0.25)
        node.runAction(SCNAction.repeatForever(spin2))*/
    }

}
