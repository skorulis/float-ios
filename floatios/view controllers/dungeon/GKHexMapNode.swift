//
//  GKHexMapNode.swift
//  floatios
//
//  Created by Alexander Skorulis on 22/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import GameplayKit

class GKHexMapNode: GKGraphNode {

    var terrain:TerrainReferenceModel
    var fixture:DungeonTileReferenceModel?
    //var items:[ItemModel]
    //var monster:CharacterModel?
    
    init(terrain:TerrainReferenceModel) {
        self.terrain = terrain
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func removeAllConnections() {
        self.removeConnections(to: self.connectedNodes, bidirectional: true)
    }
    
}
