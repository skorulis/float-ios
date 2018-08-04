//
//  HexGeometry.swift
//  Hex3D
//
//  Created by Alexander Skorulis on 1/8/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import SceneKit
import SCNMathExtensions
import FLGame

class HexGeometry: NSObject {

    let math = Hex3DMath(baseSize: 1)
    let store:GeometryStore
    let imageGen:HexTextureGenerator
    
    init(store:GeometryStore) {
        self.store = store
        self.imageGen = HexTextureGenerator()
    }
    
    func hexGeometry(ref:TerrainReferenceModel) -> SCNGeometry {
        let name = "hex-\(ref.type.rawValue)"
        return store.getGeometry(name: name, block: {return createGeometry(ref: ref)})
    }
    
    func sideGeometry() -> SCNGeometry {
        let name = "hex-sides"
        return store.getGeometry(name: name, block: createSides)
    }
    
    private func createGeometry(ref:TerrainReferenceModel) -> SCNGeometry {
        let normalUp = SCNVector3(0,1,0);
        let normalDown = SCNVector3(0,-1,0);
        
        var meshVertices:[SCNVector3] = []
        var uvPoints:[CGPoint] = []
        var meshNormals:[SCNVector3] = []
        
        for i in 0..<6 {
            meshVertices.insert(self.topPosition(self.math.regularHexPoint(index:i)), at: i)
            meshVertices.insert(self.botPosition(self.math.regularHexPoint(index:i)), at: meshVertices.count)
            
            uvPoints.insert(self.math.regularHexUV(index: i), at: i)
            uvPoints.insert(self.math.regularHexUV(index: i), at: uvPoints.count)
            
            meshNormals.insert(normalUp, at: i)
            meshNormals.insert(normalDown, at: meshNormals.count)
        }
        
        var indices:[UInt8] = [2,1,0,  5,2,0,  5,3,2,  4,3,5]
        let bottomHex = indices.reversed().map { $0 + 6}
        indices.append(contentsOf: bottomHex)
        
        let vertexSource = SCNGeometrySource(vertices: meshVertices)
        let normalSource = SCNGeometrySource(normals: meshNormals)
        let uvSource = SCNGeometrySource(textureCoordinates: uvPoints)
        
        let element = SCNGeometryElement(indices: indices, primitiveType: .triangles)
        let geometry = SCNGeometry(sources: [vertexSource,normalSource,uvSource], elements: [element])
        
        let material = SCNMaterial()
        
        material.lightingModel = .physicallyBased
        material.diffuse.contents = imageGen.topHex(ref.baseColor)
        material.normal.contents = ref.normalTexture ?? UIImage(named: "scuffed-plastic-normal")
        material.metalness.contents = UIImage(named: "scuffed-plastic-metal")
        
        geometry.firstMaterial = material
        
        return geometry
    }
    
    func createSides() -> SCNGeometry {
        var meshVertices:[SCNVector3] = []
        var uvPoints:[CGPoint] = []
        var meshNormals:[SCNVector3] = []
        var indices:[UInt8] = []
        
        for i in 0...6 {
            let i2 = (i+1)%6
            
            let v1 = self.topPosition(self.math.regularHexPoint(index:i))
            let v2 = self.topPosition(self.math.regularHexPoint(index:i2))
            let v3 = self.botPosition(self.math.regularHexPoint(index:i))
            let v4 = self.botPosition(self.math.regularHexPoint(index:i2))
            
            let i1 = UInt8(meshVertices.count)
            
            let normal = self.faceNormal(v1:v1,v2:v2)
            meshVertices.append(contentsOf: [v1,v2,v3,v4])
            meshNormals.append(contentsOf: [normal,normal,normal,normal])
            
            uvPoints.append(contentsOf: [CGPoint(x: 0, y: 0),CGPoint(x: 1, y: 0),CGPoint(x: 0, y: 1),CGPoint(x: 1, y: 1)])
            
            let faceIndices = [i1, i1+1, i1+3, i1+3, i1+2, i1]
            indices.append(contentsOf: faceIndices)
        }
        
        let vertexSource = SCNGeometrySource(vertices: meshVertices)
        let normalSource = SCNGeometrySource(normals: meshNormals)
        let uvSource = SCNGeometrySource(textureCoordinates: uvPoints)
        
        let element = SCNGeometryElement(indices: indices, primitiveType: .triangles)
        let geometry = SCNGeometry(sources: [vertexSource,normalSource,uvSource], elements: [element])
        
        let material = SCNMaterial()
        
        material.lightingModel = .physicallyBased
        material.diffuse.contents = imageGen.spikeySide(UIColor.brown)
        material.normal.contents = UIImage(named: "scuffed-plastic-normal")
        material.metalness.contents = UIImage(named: "scuffed-plastic-metal")
        
        geometry.firstMaterial = material
        
        return geometry
    }
    
    private func height() -> CGFloat {
        let p1 = math.regularHexPoint(index: 0)
        let p2 = math.regularHexPoint(index: 1)
        let v1 = SCNVector3(p1.x,0,p1.y)
        let v2 = SCNVector3(p2.x,0,p2.y)
        return CGFloat((v2 - v1).magnitude())
    }
    
    func topPosition(_ point:CGPoint) -> SCNVector3 {
        return SCNVector3(point.x,height()/2,point.y)
    }
    
    func botPosition(_ point:CGPoint) -> SCNVector3 {
        return SCNVector3(point.x,-height()/2,point.y)
    }
    
    func faceNormal(v1:SCNVector3,v2:SCNVector3) -> SCNVector3 {
        var dir = (v1 + v2)/2 - SCNVector3()
        dir.y = 0
        return dir.normalized()
    }
    
}
