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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
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
        
        sceneView.presentScene(scene)
        
        tank = SKSpriteNode(imageNamed: "tank")
        scene?.addChild(tank)
        
        map =  scene?.childNode(withName: "map") as! SKTileMapNode
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
        
        let centrePos = map.centerOfTile(atColumn: column, row: row)
        let action = SKAction.move(to: centrePos, duration: 0.25)
        action.timingMode = .easeInEaseOut
        self.tank.run(action)
        
    }

}
