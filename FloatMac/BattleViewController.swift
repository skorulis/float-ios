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

class BattleViewController: NSViewController {

    var sceneView:SCNView!
    var input:BattleInputHandler!
    
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView = self.view as! SCNView
        sceneView.allowsCameraControl = true
        
        let dunGen = DungeonGenerator(size: 3, name: "battle")
        let dungeon = dunGen.generateDungeon(type: .outdoors)
        
        let scene = BattleScene(island:dungeon)
        input = BattleInputHandler(scene:scene)
        sceneView.scene = scene
        
    }
    
    override var acceptsFirstResponder: Bool {
        return true
    }
    
    override func keyUp(with event: NSEvent) {
        print("Key event \(event)")
        if let chars = event.characters {
            self.input.castSpell(name:chars)
        }
        
    }
    
}
