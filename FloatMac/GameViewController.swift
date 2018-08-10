//
//  GameViewController.swift
//  FloatMac
//
//  Created by Alexander Skorulis on 6/8/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import SceneKit
import QuartzCore
import FLScene
import FLGame

class GameViewController: NSViewController {
    
    let scene:Map3DScene
    let game = GameController.instance
    var sceneView:SCNView!
    var input:SceneInputHandler!
    
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        self.scene = Map3DScene();
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.scene = Map3DScene();
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // retrieve the SCNView
        sceneView = self.view as! SCNView
        
        sceneView.scene = self.scene
        sceneView.allowsCameraControl = true
        sceneView.showsStatistics = true
        sceneView.backgroundColor = NSColor.black
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 4, z: 15)
        cameraNode.look(at: SCNVector3())
        
        input = SceneInputHandler(sceneView: sceneView, scene: scene, cameraNode: cameraNode)
        
        let gesture = NSClickGestureRecognizer(target: self, action: #selector(tapped(sender:)))
        sceneView.addGestureRecognizer(gesture)
    }
    
    @objc func tapped(sender:NSGestureRecognizer) {
        let location = sender.location(in: sceneView)
        input.tapped(point: CGPoint(x: location.x, y: location.y))
    }
    
}
