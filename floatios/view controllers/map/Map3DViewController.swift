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
import FLGame
import FLScene

class Map3DViewController: UIViewController {

    let scene:Map3DScene
    let game = GameController.instance
    var sceneView:SCNView!
    var inputHandler:SceneInputHandler!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let generator = DungeonGenerator(size: 7,ref:game.reference,player:game.player.player)
        let dungeon = generator.generateDungeon(type:.outdoors)
        self.scene = Map3DScene();
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = "Map"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.sceneView = SCNView(frame: self.view.bounds)
        self.view.addSubview(sceneView)
        sceneView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        sceneView.scene = self.scene
        //sceneView.allowsCameraControl = true
        sceneView.showsStatistics = true
        sceneView.backgroundColor = UIColor.black
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 8, z: 15)
        cameraNode.look(at: SCNVector3())
        
        self.inputHandler = SceneInputHandler(sceneView:self.sceneView,scene:scene,cameraNode:cameraNode)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        sceneView.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapped(_ sender:UITapGestureRecognizer) {
        let point = sender.location(in: self.sceneView)
        self.inputHandler.tapped(point:point)
    }

}
