//
//  GKHexMapNode.swift
//  floatios
//
//  Created by Alexander Skorulis on 22/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import GameplayKit

class GKHexMapNode: GKGridGraphNode {

    var terrain:TerrainReferenceModel
    var fixture:DungeonTileReferenceModel?
    //var items:[ItemModel]
    //var monster:CharacterModel?
    
    init(terrain:TerrainReferenceModel,position:vector_int2) {
        self.terrain = terrain
        super.init(gridPosition:position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func removeAllConnections() {
        self.removeConnections(to: self.connectedNodes, bidirectional: true)
    }
    
    func canPass() -> Bool {
        if let f = fixture {
            return f.canPass
        }
        return true
    }
    
}
