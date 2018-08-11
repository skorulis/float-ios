//
//  PlayerViewController.swift
//  floatios
//
//  Created by Alexander Skorulis on 29/6/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView
import FLScene

class PlayerViewController: SKCVFlowLayoutCollectionViewController {

    override init() {
        super.init()
        self.title = "Player"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.backgroundColor = UIColor.white
        let game = GameController.instance
        
        game.majorState.observers.add(object: self) { [unowned self] _ in
            self.sections.reloadData()
        }
        
        let actionRefs:[ActionReferenceModel] = game.reference.allActions()
        
        let char = game.player.player.base
        let charSection = PlayerDetailsCell.defaultSection(object: char, collectionView: collectionView!)
        
        let activeActions = SKCVSectionController()
        SectionHeaderView.updateSectionHeader(section: activeActions, model: "Actions", kind: UICollectionElementKindSectionHeader, collectionView: collectionView!)
        
        let blockedActions = SKCVSectionController()
        SectionHeaderView.updateSectionHeader(section: blockedActions, model: "Unavailable", kind: UICollectionElementKindSectionHeader, collectionView: collectionView!)
        
        activeActions.didSelectItemAt = {[unowned self] (collectionView,indexPath) in
            let cell = collectionView.cellForItem(at: indexPath) as! ActionCell
            game.player.performAction(action: cell.model!)
            self.sections.reloadData()
            if (cell.model!.type == .dungeon) {
                
            }
        }
        
        self.sections.preReloadBlock = { [unowned self] in
            let split = actionRefs.splitArray(by: { (act) -> Bool in
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
        
        let skillsSection = ForwardNavigationCell.defaultSection(object: "Skills", collectionView: collectionView!)
        skillsSection.didSelectItemAt = {(collectionView,indexPath) in
            let vc = SkillListViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        sections.add(section: charSection)
        sections.add(section: itemSection)
        sections.add(section: journalSection)
        sections.add(section: skillsSection)
        sections.add(section: statSection)
        sections.add(section: activeActions)
        sections.add(section: blockedActions)
        
        self.sections.reloadData()
        
    }
    
}
