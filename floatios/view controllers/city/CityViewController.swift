//
//  CityViewController.swift
//  floatios
//
//  Created by Alexander Skorulis on 30/6/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView

private let reuseIdentifier = "Cell"

class CityViewController: SKCVFlowLayoutCollectionViewController {

    let game = GameController.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let city = game.city.city
        let detailSection = CityDetailsCell.defaultSection(object: city, collectionView: collectionView!)
        
        self.sections.add(section: detailSection)
        
    }

}
