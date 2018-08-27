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
import FLScene
import SKSwiftLib

class Map3DViewController: UIViewController, SceneInputHandlerDelegate {

    let scene:Map3DScene
    let game = GameController.instance
    var sceneView:SCNView!
    var inputHandler:SceneInputHandler!
    
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
        
        let shareButton = UIBarButtonItem(title: "share", style: .plain, target: self, action: #selector(sharePressed(sender:)))
        let editButton = UIBarButtonItem(title: "edit", style: .plain, target: self, action: #selector(editPressed(sender:)))

        self.navigationItem.rightBarButtonItems = [shareButton,editButton]
        
        self.sceneView = SCNView(frame: self.view.bounds)
        self.view.addSubview(sceneView)
        sceneView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        sceneView.scene = self.scene
        sceneView.allowsCameraControl = false
        //sceneView.defaultCameraController.interactionMode = .fly
        sceneView.showsStatistics = true
        sceneView.backgroundColor = UIColor.black
        
        let cameraNode = SCNNode()
        
        let camera = SCNCamera()
        camera.motionBlurIntensity = 1.0
        
        cameraNode.camera = camera
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 8, z: 15)
        cameraNode.look(at: SCNVector3())
        
        self.inputHandler = SceneInputHandler(sceneView:self.sceneView,scene:scene,cameraNode:cameraNode)
        self.inputHandler.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        sceneView.addGestureRecognizer(tapGesture)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
        sceneView.addGestureRecognizer(longPressGesture)
    }
    
    @objc func tapped(_ sender:UITapGestureRecognizer) {
        let point = sender.location(in: self.sceneView)
        self.inputHandler.tapped(point:point)
    }
    
    @objc func longPress(_ sender:UILongPressGestureRecognizer) {
        if (sender.state != .began) {
            return
        }
        let point = sender.location(in: self.sceneView)
        self.inputHandler.longPress(point: point)
    }

    //MARK: SceneInputHandlerDelegate
        
    func showLandOptions(node:MapHexModel,actions:[DungeonAction]) {
        if actions.count == 0 {
            return //Ignore
        }
        let alert = UIAlertController(title: "Choose action", message: nil, preferredStyle: .actionSheet)
        
        for a in actions {
            let button = UIAlertAction(title: a.rawValue, style: .default) { (aa) in
                self.inputHandler.performAction(node: node, action:a)
            }
            alert.addAction(button)
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: actions
    
    @objc func sharePressed(sender:UIBarButtonItem) {
        
    }
    
    @objc func editPressed(sender:Any) {
        
    }
}
