//
//  MaterialProvider.swift
//  FLScene
//
//  Created by Alexander Skorulis on 5/8/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import SceneKit
import FLGame

class MaterialProvider: NSObject {

    class func sideMaterial(ref:TerrainReferenceModel) -> SCNMaterial {
        let material = SCNMaterial()
        material.lightingModel = .physicallyBased
        material.diffuse.contents = ref.baseColor
        
        switch ref.type {
        case .redRock:
            material.diffuse.contents = UIImage(named:"montagne_albedo")
            material.normal.contents = UIImage(named: "montagne_normal")
            material.roughness.contents = UIImage(named:"montagne_roughness")
        default:
            let imageGen = HexTextureGenerator()
            material.diffuse.contents = imageGen.spikeySide(ref.baseColor)
        }
        
        return material
    }
    
    class func topMaterial(ref:TerrainReferenceModel) -> SCNMaterial {
        let material = SCNMaterial()
        material.lightingModel = .physicallyBased
        material.diffuse.contents = ref.baseColor
        
        switch ref.type {
        case .redRock:
            material.diffuse.contents = UIImage(named: "montagne_top_albedo")
            material.normal.contents = UIImage(named: "montagne_top_normal")
            material.roughness.contents = UIImage(named: "montagne_top_roughness")
        default:
            let imageGen = HexTextureGenerator()
            material.diffuse.contents = imageGen.topHex(ref.baseColor)
            material.normal.contents = ref.normalTexture ?? UIImage(named: "scuffed-plastic-normal")
            material.metalness.contents = UIImage(named: "scuffed-plastic-metal")
        }
        
        return material
    }
    
}
