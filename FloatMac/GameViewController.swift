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

class GameViewController: BaseMacViewController, SceneInputHandlerDelegate {
    
    let scene:OverlandScene
    let game = GameController.instance
    var input:SceneInputHandler!
    var sceneDelegate:BattleSceneDelegate!
    
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        self.scene = OverlandScene()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.scene = OverlandScene()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.scene = self.scene
        //sceneView.allowsCameraControl = true
        
        input = SceneInputHandler(sceneView: sceneView, scene: scene, cameraNode: scene.cameraNode  )
        input.delegate = self
        
        let gesture = NSClickGestureRecognizer(target: self, action: #selector(tapped(sender:)))
        gesture.buttonMask = 1
        sceneView.addGestureRecognizer(gesture)
        
        let rightClickGesture = NSClickGestureRecognizer(target: self, action: #selector(rightClicked(sender:)))
        rightClickGesture.buttonMask = 2
        sceneView.addGestureRecognizer(rightClickGesture)
        //sceneView.debugOptions = SCNDebugOptions.showBoundingBoxes
        
        sceneDelegate = BattleSceneDelegate(scene:scene)
        sceneView.delegate = sceneDelegate
        scene.physicsWorld.contactDelegate = sceneDelegate
        
        sceneView.isPlaying = true
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
    
    func showLandOptions(node:MapHexModel,actions:[ActionType]) {
        if (actions.count == 1) {
            self.input.performAction(node: node, action: actions[0])
        }
    }
    
    func saveMap(sender:NSMenuItem?) {
        do {
            let rootDir = "/Users/alex/dev/floats/FLScene/FLScene/Resources/data/"
            let islandMeta = scene.overland.dungeons.map { $0.metaData()}
            let bridgeArray = try scene.overland.bridgeJSONArray()
            let jsonObj = ["islands":islandMeta,"bridges":bridgeArray]
            let data = try JSONSerialization.data(withJSONObject: jsonObj, options: [])
            let fileURL = URL(fileURLWithPath: rootDir + "overland.json")
            try data.write(to: fileURL)
            
            for island in scene.overland.dungeons {
                let data = try JSONEncoder().encode(island)
                let filePath = "\(rootDir)\(island.name).json"
                let fileURL = URL(fileURLWithPath: filePath)
                try data.write(to: fileURL)
            }
            
        } catch {
            print("Error saving maps \(error)")
        }
    }
    
    
}
