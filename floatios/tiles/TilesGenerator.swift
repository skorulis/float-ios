//
//  TilesGenerator.swift
//  floatios
//
//  Created by Alexander Skorulis on 20/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKSwiftLib

class TilesGenerator: NSObject {

    let tileSize:CGSize
    let rootDir:String = "tiles"
    
    init(tileSize:CGSize) {
        self.tileSize = tileSize
        
        let path = PathHelper.documentsDirectoryPath() + rootDir
        do {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: false, attributes: nil)
        } catch {
            
        }
        
        print("Writing tiles to " + path)
    }
    
    func saveTile(img:UIImage,name:String) {
        let data = UIImagePNGRepresentation(img)
        let fileName = name + ".png"
        let fileURL = PathHelper.documentsDirectory().appendingPathComponent(rootDir).appendingPathComponent(fileName)
        do {
            try data?.write(to: fileURL)
        } catch {}
        
    }
    
    func generateEmptyTile(name:String) -> UIImage {
        UIGraphicsBeginImageContext(tileSize)
        let ctx = UIGraphicsGetCurrentContext()
        
        
        
        let img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img!
    }
    
    static func generateAllTiles() {
        let gen = TilesGenerator(tileSize: CGSize(width: 60, height: 70))
        let t1 = gen.generateEmptyTile(name: "test")
        gen.saveTile(img: t1, name: "test")
    }
    
}
