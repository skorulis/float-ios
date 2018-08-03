//
//  ImageGen.swift
//  floatios
//
//  Created by Alexander Skorulis on 3/8/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKSwiftLib

open class ImageGen: NSObject {
    
    let rootDir:String
    
    init(rootDir:String) {
        self.rootDir = rootDir
        
        let path = PathHelper.documentsDirectoryPath() + rootDir
        do {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: false, attributes: nil)
        } catch {
            
        }
        
        print("Writing images to " + path)
    }
    
    public func saveImage(name:String,image:UIImage) {
        let data = UIImagePNGRepresentation(image)
        let fileName = name + ".png"
        let fileURL = PathHelper.documentsDirectory().appendingPathComponent(rootDir).appendingPathComponent(fileName)
        do {
            try data?.write(to: fileURL)
        } catch {}
    }

    public func finishContext() -> UIImage {
        let img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img!
    }
    
    public func newContext(_ size:CGSize) -> CGContext {
        UIGraphicsBeginImageContext(size)
        return UIGraphicsGetCurrentContext()!
    }
    
}

