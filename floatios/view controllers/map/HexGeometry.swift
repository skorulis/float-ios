//
//  HexGeometry.swift
//  Hex3D
//
//  Created by Alexander Skorulis on 1/8/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import SceneKit
import SCNMathExtensions

class HexGeometry: NSObject {

    let math = HexGridMath(tileSize: CGSize(width: 3, height: 3))
    
    func getGeometry() -> SCNGeometry {
        let t1 = topPosition(regularHexPoint(index:0))
        let t2 = topPosition(regularHexPoint(index:1))
        let t3 = topPosition(regularHexPoint(index:2))
        let t4 = topPosition(regularHexPoint(index:3))
        let t5 = topPosition(regularHexPoint(index:4))
        let t6 = topPosition(regularHexPoint(index:5))
        
        let b1 = botPosition(regularHexPoint(index:0))
        let b2 = botPosition(regularHexPoint(index:1))
        let b3 = botPosition(regularHexPoint(index:2))
        let b4 = botPosition(regularHexPoint(index:3))
        let b5 = botPosition(regularHexPoint(index:4))
        let b6 = botPosition(regularHexPoint(index:5))
        
        var meshVertices:[SCNVector3] = [t1,t2,t3,t4,t5,t6,
                                         b1,b2,b3,b4,b5,b6]
        
        let normalUp = SCNVector3(0,1,0);
        let normalDown = SCNVector3(0,-1,0);
        
        var meshNormals:[SCNVector3] =
            [normalUp,normalUp,normalUp,normalUp,normalUp,normalUp,
        normalDown,normalDown,normalDown,normalDown,normalDown,normalDown]
        
        var indices:[UInt8] = [2,1,0,  5,2,0,  5,3,2,  4,3,5]
        let bottomHex = indices.reversed().map { $0 + 6}
        indices.append(contentsOf: bottomHex)
        
        for i in 0...6 {
            let i2 = (i+1)%6
            
            let v1 = meshVertices[i]
            let v2 = meshVertices[i2]
            let v3 = meshVertices[i + 6]
            let v4 = meshVertices[i2 + 6]
            
            let i1 = UInt8(meshVertices.count)
            
            let normal = faceNormal(v1:v1,v2:v2)
            meshVertices.append(contentsOf: [v1,v2,v3,v4])
            meshNormals.append(contentsOf: [normal,normal,normal,normal])
            
            let faceIndices = [i1, i1+1, i1+3, i1+3, i1+2, i1]
            indices.append(contentsOf: faceIndices)
        }
        
        let vertexSource = SCNGeometrySource(vertices: meshVertices)
        let normalSource = SCNGeometrySource(normals: meshNormals)
        
        let element = SCNGeometryElement(indices: indices, primitiveType: .triangles)
        let geometry = SCNGeometry(sources: [vertexSource,normalSource], elements: [element])
        
        geometry.firstMaterial = SCNMaterial()
        geometry.firstMaterial?.diffuse.contents = UIColor.red
        
        return geometry
    }
    
    func regularHexPoint(index:Int) -> CGPoint {
        let angle = (CGFloat(index) * CGFloat.pi / 3) - CGFloat.pi/2
        return CGPoint(angle: angle, length: 1)
    }
    
    func topPosition(_ point:CGPoint) -> SCNVector3 {
        return SCNVector3(point.x,1,point.y)
    }
    
    func botPosition(_ point:CGPoint) -> SCNVector3 {
        return SCNVector3(point.x,-1,point.y)
    }
    
    func faceNormal(v1:SCNVector3,v2:SCNVector3) -> SCNVector3 {
        var dir = (v1 + v2)/2 - SCNVector3()
        dir.y = 0
        return dir.normalized()
    }
    
}
