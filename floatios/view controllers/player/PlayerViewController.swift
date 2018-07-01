//
//  PlayerViewController.swift
//  floatios
//
//  Created by Alexander Skorulis on 29/6/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView

class PlayerViewController: SKCVFlowLayoutCollectionViewController {

    let game = GameController.instance
    let actions:[CharacterAction] = [.sleep,.eat,.forage]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.white
        
        let char = game.player.player.base
        self.title = char.name
        let charSection = PlayerDetailsCell.defaultSection(object: char, collectionView: collectionView!)
        
        let activeActions = SKCVSectionController()
        SectionHeaderView.updateSectionHeader(section: activeActions, model: "Actions", kind: UICollectionElementKindSectionHeader, collectionView: collectionView!)
        
        let blockedActions = SKCVSectionController()
        SectionHeaderView.updateSectionHeader(section: blockedActions, model: "Unavailable", kind: UICollectionElementKindSectionHeader, collectionView: collectionView!)
        
        activeActions.didSelectItemAt = {(collectionView,indexPath) in
            let cell = collectionView.cellForItem(at: indexPath) as! ActionCell
            self.game.player.performCharacterAction(action: cell.model!)
            self.sections.reloadData()
        }
        
        self.sections.preReloadBlock = { [unowned self] in
            let split = self.actions.split(by: { (act) -> Bool in
                return self.game.action.hasRequirements(character: char, action: act)
            })
            
            ActionCell.updateSection(section: activeActions, items: split.passing, collectionView: self.collectionView!)
            ActionCell.updateSection(section: blockedActions, items: split.failing, collectionView: self.collectionView!)
        }
        
        let itemSection = ForwardNavigationCell.defaultSection(object: "Inventory", collectionView: collectionView!)
        itemSection.didSelectItemAt = {(collectionView,indexPath) in
            let vc = InventoryViewController(inventory: char.inventory)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        sections.add(section: charSection)
        sections.add(section: itemSection)
        sections.add(section: activeActions)
        sections.add(section: blockedActions)
        
        self.sections.reloadData()
        
    }
    

}
