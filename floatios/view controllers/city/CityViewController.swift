//
//  CityViewController.swift
//  floatios
//
//  Created by Alexander Skorulis on 30/6/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView
import FLScene

private let reuseIdentifier = "Cell"

class CityViewController: SKCVFlowLayoutCollectionViewController {

    let game = GameController.instance
    
    override init() {
        super.init()
        self.title = "City"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.white

        let city = game.city.city
        let detailSection = CityDetailsCell.defaultSection(object: city, collectionView: collectionView!)
        
        let landSection = ForwardNavigationCell.defaultSection(object: "Land", collectionView: collectionView!)
        landSection.didSelectItemAt = {[unowned self] (collectionView,indexPath) in
            let vc = CityLandController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let actionsSection = ForwardNavigationCell.defaultSection(object: "Actions", collectionView: collectionView!)
        actionsSection.didSelectItemAt = {[unowned self] (collectionView,indexPath) in
            let vc = PlayerViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let occupantSection = PlayerDetailsCell.defaultSection(getModel: self.game.city.occupants.getRow,getCount:self.game.city.occupants.sectionCount, collectionView: collectionView!)
        occupantSection.didSelectItemAt = {[unowned self] (collectionView,indexPath) in
            let vc = NPCViewController()
            vc.npc = self.game.city.occupants.getRow(indexPath: indexPath)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        self.sections.add(section: detailSection)
        self.sections.add(section: landSection)
        self.sections.add(section: actionsSection)
        self.sections.add(section: occupantSection)
        
    }

}
