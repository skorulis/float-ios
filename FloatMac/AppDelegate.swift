//
//  AppDelegate.swift
//  FloatMac
//
//  Created by Alexander Skorulis on 6/8/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import Cocoa
import FLScene

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    private func gameVC() -> GameViewController {
        let window = NSApplication.shared.windows.first
        let gameVC = window?.contentViewController as? GameViewController
        return gameVC!
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        ReferenceController.instance.readNamedSpells()
        
        //HexTextureGenerator.generateAllImages()
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        let window = NSApplication.shared.windows.first
        let firstVC = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "GameScene")) as? NSViewController
        window?.contentViewController = firstVC
    }
    
    @IBAction func saveMap(sender:NSMenuItem?) {
        gameVC().saveMap(sender: nil)
    }
    
    @IBAction func editPressed(sender:NSMenuItem) {
        if sender.state == .on {
            gameVC().input.editHandler.editMode = false
            sender.state = .off
        } else {
            gameVC().input.editHandler.editMode = true
            sender.state = .on
        }
        
        gameVC().sceneView.allowsCameraControl = gameVC().input.editHandler.editMode
    }
    
    @IBAction func cycleTerrain(sender:NSMenuItem) {
        gameVC().input.editHandler.cycleTerrain(backwards:false)
    }
    
    @IBAction func previousTerrain(sender:NSMenuItem) {
        gameVC().input.editHandler.cycleTerrain(backwards:true)
    }
    
    @IBAction func moveTerrainDown(sender:NSMenuItem) {
        gameVC().input.editHandler.moveTerrain(amount: -1)
    }
    
    @IBAction func moveTerrainUp(sender:NSMenuItem) {
        gameVC().input.editHandler.moveTerrain(amount: 1)
    }
    
}
