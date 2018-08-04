//
//  InventoryViewController.swift
//  floatios
//
//  Created by Alexander Skorulis on 1/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView
import FLGame

class InventoryViewController: SKCVFlowLayoutCollectionViewController {
    
    let game = GameController.instance
    let inventory:InventoryModel
    
    init(inventory:InventoryModel) {
        self.inventory = inventory
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.white
        self.title = "Inventory"
        
        let section = ItemCell.defaultSection(items: inventory.items, collectionView: collectionView!)
        self.sections.add(section: section)
        
    }
}
