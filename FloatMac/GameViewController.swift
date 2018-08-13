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

class GameViewController: NSViewController, SceneInputHandlerDelegate {
    
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
        //sceneView.allowsCameraControl = true
        sceneView.showsStatistics = true
        sceneView.backgroundColor = NSColor.black
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 4, z: 15)
        cameraNode.look(at: SCNVector3())
        
        input = SceneInputHandler(sceneView: sceneView, scene: scene, cameraNode: cameraNode)
        input.delegate = self
        
        let gesture = NSClickGestureRecognizer(target: self, action: #selector(tapped(sender:)))
        gesture.buttonMask = 1
        sceneView.addGestureRecognizer(gesture)
        
        let rightClickGesture = NSClickGestureRecognizer(target: self, action: #selector(rightClicked(sender:)))
        rightClickGesture.buttonMask = 2
        sceneView.addGestureRecognizer(rightClickGesture)
        
        do {
            let jsonModel = scene.overland.deflated()
            let data = try JSONEncoder().encode(jsonModel)
            let fileURL = URL(fileURLWithPath: "/Users/alex/dev/floats/mapTest.json")
            try data.write(to: fileURL)
        } catch {
            print("Error saving maps \(error)")
        }
        
    }
    
    @objc func tapped(sender:NSGestureRecognizer) {
        let location = sender.location(in: sceneView)
        input.tapped(point: CGPoint(x: location.x, y: location.y))
    }
    
    @objc func rightClicked(sender:NSGestureRecognizer) {
        let location = sender.location(in: sceneView)
        input.longPress(point: location)
    }
    
    //MARK: SceneInputHandlerDelegate
    
    func showLandOptions(node:GKHexMapNode,actions:[DungeonAction]) {
        if (actions.count == 1) {
            self.input.performAction(node: node, action: actions[0])
        }
    }
    
}
