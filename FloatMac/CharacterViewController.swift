//
//  CharacterViewController.swift
//  FloatMac
//
//  Created by Alexander Skorulis on 8/9/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import Cocoa
import FLScene

class CharacterViewController: BaseMacViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let islandGen = DungeonGenerator(size: 1, name: "battle")
        let island = islandGen.generateDungeon(type: .outdoors)
        
        let player:CharacterModel = ReferenceController.readJSONFile(filename: "battleCharacter")!
        
        let scene = CharacterScene(island:island,character:player)
        
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
        
    }
    
}
