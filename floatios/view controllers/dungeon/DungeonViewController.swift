//
//  DungeonViewController.swift
//  floatios
//
//  Created by Alexander Skorulis on 18/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SpriteKit
import SnapKit

class DungeonViewController: UIViewController {
    
    var sceneView:SKView!
    var scene:SKScene!
    let dungeon:DungeonModel
    let dungeonNode:SKDungeonNode
    let header = DungeonHeaderView()
    let logic:DungeonLogicController
    let camera = SKCameraNode()
    let game = GameController.instance
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let generator = DungeonGenerator(size: 50,ref:game.reference)
        self.dungeon = generator.generateDungeon()
        self.dungeon.player = game.player.player
        dungeonNode = SKDungeonNode(dungeon: self.dungeon)
        self.logic = DungeonLogicController(dungeon: dungeon,ref:game.reference)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = "Dungeon"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scene = SKScene(fileNamed: "CityScene")
        self.sceneView = SKView()
        self.view.addSubview(self.sceneView)
        self.view.addSubview(self.header)
        self.header.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            
        }
        
        sceneView.snp.makeConstraints { (make) in
            make.top.equalTo(header.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        let map = scene?.childNode(withName: "map") as! SKTileMapNode
        map.removeFromParent()
        
        scene.addChild(dungeonNode)
        
        self.scene.camera = self.camera
        self.scene.addChild(self.camera)
        
        self.camera.position = self.dungeonNode.tank.position
        
        sceneView.presentScene(scene)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(recognizer:)))
        self.sceneView.addGestureRecognizer(tap)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(recognizer:)))
        self.sceneView.addGestureRecognizer(longPress)
        
        self.header.update(player: dungeon.player)
    }
    
    func showActionAlert(actions:[DungeonAction]) {
        let alert = UIAlertController(title: "Choose action", message: nil, preferredStyle: .actionSheet)
        
        for a in actions {
            let button = UIAlertAction(title: a.rawValue, style: .default) { (aa) in
                
            }
            alert.addAction(button)
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func longPressed(recognizer:UITapGestureRecognizer) {
        if recognizer.state != .began {
            return
        }
        let mapPoint = getMapPoint(recognizer: recognizer)
        let actions = logic.getActions(at: mapPoint)
        
        if actions.count > 0 {
            showActionAlert(actions: actions)
        }
    }
    
    @objc func tapped(recognizer:UITapGestureRecognizer) {
        if recognizer.state != .ended {
            return
        }
        let mapPoint = getMapPoint(recognizer: recognizer)
        if (!self.dungeon.isInMap(point: mapPoint)) {
            return
        }
        
        let map = self.dungeonNode.terrain
        
        if let type = dungeon.fixture(at: mapPoint) {
            let dungeonTile = game.reference.getDungeonTile(type:type)
            if (!dungeonTile.canPass) {
                return //Can't go past this tile
            }
        }
        
        let centrePos = map.centerOfTile(at:mapPoint)
        let action = SKAction.move(to: centrePos, duration: 0.25)
        action.timingMode = .easeInEaseOut
        self.dungeonNode.tank.run(action)
        
        let camAction = SKAction.move(to: centrePos, duration: 0.25)
        camAction.timingMode = .easeInEaseOut
        self.camera.run(camAction)
        
    }
    
    private func getMapPoint(recognizer:UIGestureRecognizer) -> CGPoint {
        let map = self.dungeonNode.terrain
        
        let viewLoc = recognizer.location(in: recognizer.view)
        let location = self.scene.convertPoint(fromView: viewLoc)
        let mapLoc = map.convert(location, from: self.scene)
        
        let column = map.tileColumnIndex(fromPosition: mapLoc)
        let row = map.tileRowIndex(fromPosition: mapLoc)
        
        return CGPoint(x: row, y: column)
    }

}
