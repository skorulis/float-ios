//
//  BattleViewController.swift
//  FloatMac
//
//  Created by Alexander Skorulis on 18/8/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import SceneKit
import QuartzCore
import FLScene

class BattleViewController: BaseMacViewController {

    var input:BattleInputHandler!
    var sceneDelegate:BattleSceneDelegate!
    
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.allowsCameraControl = true
        
        let dunGen = DungeonGenerator(size: 5, name: "battle")
        let dungeon = dunGen.generateDungeon(type: .outdoors)
        
        let arena:FullArenaModel = ReferenceController.readJSONFile(filename: "arena1")!
        let battle = arena.battles[0]
        
        let player:CharacterModel = ReferenceController.readJSONFile(filename: "battleCharacter")!
        player.skills = SkillListModel.defaultSkills()
        
        let scene = BattleScene(island:dungeon,battleModel:battle,playerCharacter:player)
        input = BattleInputHandler(sceneView:sceneView, scene:scene)
        sceneView.scene = scene
        
        let gesture = NSClickGestureRecognizer(target: self, action: #selector(tapped(sender:)))
        gesture.buttonMask = 1
        sceneView.addGestureRecognizer(gesture)
        
        sceneDelegate = BattleSceneDelegate(scene:scene)
        
        sceneView.delegate = sceneDelegate
        scene.physicsWorld.contactDelegate = sceneDelegate
        sceneView.isPlaying = true
    }
    
    override var acceptsFirstResponder: Bool {
        return true
    }
    
    override func keyUp(with event: NSEvent) {
        if let chars = event.characters {
            self.input.keyUp(name:chars)
        }
    }
    
    override func keyDown(with event: NSEvent) {
        if let chars = event.characters {
            self.input.keyDown(name:chars)
        }
    }
    
    @objc func tapped(sender:NSGestureRecognizer) {
        let location = sender.location(in: sceneView)
        input.tapped(point: CGPoint(x: location.x, y: location.y))
    }
    
}
