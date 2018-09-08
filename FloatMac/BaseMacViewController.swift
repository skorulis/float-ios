//
//  BaseMacViewController.swift
//  FloatMac
//
//  Created by Alexander Skorulis on 8/9/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import Cocoa
import SceneKit

class BaseMacViewController: NSViewController {

    var sceneView:SCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // retrieve the SCNView
        sceneView = self.view as! SCNView
        sceneView.showsStatistics = true
        
    }
    
}
