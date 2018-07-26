//
//  DungeonModel.swift
//  floatios
//
//  Created by Alexander Skorulis on 20/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class DungeonModel: NSObject {
    
    var player:PlayerCharacterModel
    var playerNode:DungeonCharacterEntity
    
    var nodes:[GKHexMapNode] = []
    var width:Int
    var height:Int
    var graph:GKGraph
    
    init(width:Int,height:Int,baseTerrain:TerrainReferenceModel,player:PlayerCharacterModel) {
        self.width = width
        self.height = height
        self.player = player
        self.playerNode = DungeonCharacterEntity(char:self.player.base)
        
        for y in 0..<height {
            for x in 0..<width {
                nodes.append(GKHexMapNode(terrain: baseTerrain,position:vector_int2(Int32(x),Int32(y))))
            }
        }
        
        for n in nodes {
            print("pos \(n.gridPosition)")
        }
        
        graph = GKGraph(nodes)   
    }
    
    func updateConnectionGraph() {
        for node in nodes {
            node.removeAllConnections()
        }
        
        for y in 0..<height {
            for x in 0..<width {
                let node = self.nodeAt(x: x, y: y)!
                if !node.canPass() {
                    continue //Don't connect
                }
                tryConnect(node: node, x: x-1, y: y)
                tryConnect(node: node, x: x+1, y: y)
                if y % 2 == 1 {
                    tryConnect(node: node, x: x, y: y+1)
                    tryConnect(node: node, x: x+1, y: y+1)
                } else {
                    tryConnect(node: node, x: x-1, y: y+1)
                    tryConnect(node: node, x: x, y: y+1)
                }
            }
        }
    }
    
    func tryConnect(node:GKHexMapNode,x:Int,y:Int) {
        if let other = self.nodeAt(x: x, y: y) {
            if (!other.canPass()) {
                return //Don't connect
            }
            node.addConnections(to: [other], bidirectional: true)
        }
    }
    
    func nodeAt(point:CGPoint) -> GKHexMapNode? {
        return nodeAt(x: Int(point.x), y: Int(point.y))
    }
    
    func nodeAt(x:Int,y:Int) -> GKHexMapNode? {
        if (!isInMap(x: x, y: y)) {
            return nil
        }
        let index = y * width + x
        return nodes[index]
    }
    
    func isInMap(point:CGPoint) -> Bool {
        return isInMap(x: Int(point.x), y: Int(point.y))
    }
    
    func isInMap(x:Int,y:Int) -> Bool {
        return x >= 0 && y >= 0 && x < width && y < height
    }
    
    func fixture(at:CGPoint) -> DungeonTileType? {
        let node = self.nodeAt(point: at)
        return node?.fixture?.type
    }
    
    func path(to:CGPoint,from:CGPoint) -> [GKHexMapNode] {
        guard let node = self.nodeAt(point: to) else { return [] }
        guard let fromNode = self.nodeAt(point: from) else { return [] }
        
        return graph.findPath(from: fromNode, to: node) as! [GKHexMapNode]
    }
    
}
