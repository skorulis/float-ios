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
        self.collectionView?.backgroundColor = UIColor.white
        
        self.title = game.city.city.name

        let city = game.city.city
        let detailSection = CityDetailsCell.defaultSection(object: city, collectionView: collectionView!)
        
        let landSection = ForwardNavigationCell.defaultSection(object: "Land", collectionView: collectionView!)
        landSection.didSelectItemAt = {[unowned self] (collectionView,indexPath) in
            let vc = CityLandController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let getOccupant:(IndexPath) -> (CharacterModel?) = { (indexPath) -> CharacterModel? in
            return self.game.city.occupants[indexPath.row]
        }
        let occupantCount:SectionCountBlock = { (UICollectionView,Int) -> Int in
            return self.game.city.occupants.count
        }
        
        let occupantSection = PlayerDetailsCell.defaultSection(getModel: getOccupant,getCount:occupantCount, collectionView: collectionView!)
        
        
        self.sections.add(section: detailSection)
        self.sections.add(section: landSection)
        self.sections.add(section: occupantSection)
        
    }

}
