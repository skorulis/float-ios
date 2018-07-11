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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.white
        let game = GameController.instance
        
        game.majorState.observers.add(object: self) { [unowned self] _ in
            self.sections.reloadData()
        }
        
        let actionRefs:[ActionReferenceModel] = game.reference.allActions()
        
        let char = game.player.player.base
        self.title = char.name
        let charSection = PlayerDetailsCell.defaultSection(object: char, collectionView: collectionView!)
        
        let activeActions = SKCVSectionController()
        SectionHeaderView.updateSectionHeader(section: activeActions, model: "Actions", kind: UICollectionElementKindSectionHeader, collectionView: collectionView!)
        
        let blockedActions = SKCVSectionController()
        SectionHeaderView.updateSectionHeader(section: blockedActions, model: "Unavailable", kind: UICollectionElementKindSectionHeader, collectionView: collectionView!)
        
        activeActions.didSelectItemAt = {(collectionView,indexPath) in
            let cell = collectionView.cellForItem(at: indexPath) as! ActionCell
            game.player.performAction(action: cell.model!)
            self.sections.reloadData()
        }
        
        self.sections.preReloadBlock = { [unowned self] in
            let split = actionRefs.split(by: { (act) -> Bool in
                return game.action.hasRequirements(character: char, action: act)
            })
            
            let blocked = split.failing.filter { game.action.shouldShow(action: $0, character: char)}
            
            ActionCell.updateSection(section: activeActions, items: split.passing, collectionView: self.collectionView!)
            ActionCell.updateSection(section: blockedActions, items: blocked, collectionView: self.collectionView!)
        }
        
        let itemSection = ForwardNavigationCell.defaultSection(object: "Inventory", collectionView: collectionView!)
        itemSection.didSelectItemAt = {(collectionView,indexPath) in
            let vc = InventoryViewController(inventory: char.inventory)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let statSection = ForwardNavigationCell.defaultSection(object: "Stats", collectionView: collectionView!)
        statSection.didSelectItemAt = {(collectionView,indexPath) in
            let vc = PlayerStatsViewController(player:game.player.player)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let journalSection = ForwardNavigationCell.defaultSection(object: "Journal", collectionView: collectionView!)
        journalSection.didSelectItemAt = {(collectionView,indexPath) in
            let vc = JournalViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        sections.add(section: charSection)
        sections.add(section: itemSection)
        sections.add(section: journalSection)
        sections.add(section: statSection)
        sections.add(section: activeActions)
        sections.add(section: blockedActions)
        
        self.sections.reloadData()
        
    }
    

}
