//
//  CityLandController.swift
//  floatios
//
//  Created by Alexander Skorulis on 30/6/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView
import FLScene

class CityLandController: SKCVFlowLayoutCollectionViewController {

    let game = GameController.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.white
        self.title = "Land"
        
        let city = self.game.city.city
        
        let landSection = LandSquareCell.defaultSection(getModel: city.squares.getRow,getCount:city.squares.sectionCount, collectionView: collectionView!)
        
        self.sections.add(section: landSection)
        
    }
    
}
