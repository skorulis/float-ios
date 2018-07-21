//
//  DungeonViewController.swift
//  floatios
//
//  Created by Alexander Skorulis on 18/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SpriteKit

class DungeonViewController: UIViewController {
    
    var map:SKTileMapNode!
    var tank:SKSpriteNode!
    var sceneView:SKView!
    var scene:SKScene!
    var dungeon:DungeonModel
    let camera = SKCameraNode()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let generator = DungeonGenerator()
        self.dungeon = generator.generateDungeon(size: 5)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = "Dungeon"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = SKView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.scene = SKScene(fileNamed: "CityScene")
        self.sceneView = self.view as! SKView
        
        map =  scene?.childNode(withName: "map") as! SKTileMapNode
        map.removeFromParent()
        
        scene.addChild(dungeon.terrain)
        scene.addChild(dungeon.walls)
        
        self.scene.camera = self.camera
        self.scene.addChild(self.camera)
        
        sceneView.presentScene(scene)
        
        tank = SKSpriteNode(imageNamed: "tank")
        scene!.addChild(tank)
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(recognizer:)))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func tapped(recognizer:UITapGestureRecognizer) {
        if recognizer.state != .ended {
            return
        }
        
        let viewLoc = recognizer.location(in: recognizer.view)
        let location = self.scene.convertPoint(fromView: viewLoc)
        let mapLoc = self.map.convert(location, from: self.scene)
        
        let column = map.tileColumnIndex(fromPosition: mapLoc)
        let row = map.tileRowIndex(fromPosition: mapLoc)
        
        guard let _ = map.tileDefinition(atColumn: column, row: row) else {
            return //Can't go off the edget of the map
        }
        
        
        let centrePos = map.centerOfTile(atColumn: column, row: row)
        let action = SKAction.move(to: centrePos, duration: 0.25)
        action.timingMode = .easeInEaseOut
        self.tank.run(action)
        
        let camAction = SKAction.move(to: centrePos, duration: 0.25)
        camAction.timingMode = .easeInEaseOut
        self.camera.run(camAction)
        
    }

}
