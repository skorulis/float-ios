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
        
        collectionView?.register(clazz: ActionCell.self)
        collectionView?.register(clazz: PlayerDetailsCell.self)
        
        let char = game.player.player.base
        
        let charSection = PlayerDetailsCell.defaultSection(object: char, collectionView: collectionView!)
        
        let itemSection = SKCVSectionController()
        itemSection.simpleNumberOfItemsInSection = {[unowned self] in return self.actions.count}
        
        let getModel:(IndexPath) -> (CharacterAction?) = { (indexPath) -> CharacterAction? in
            return self.actions[indexPath.row]
        }
        
        itemSection.cellForItemAt = ActionCell.curriedDefaultCell(getModel: getModel)
        itemSection.sizeForItemAt = ActionCell.curriedCalculateSize(getModel: getModel)
        itemSection.didSelectItemAt = {(collectionView,indexPath) in
            let action = self.actions[indexPath.row]
            self.game.player.performCharacterAction(action: action)
            self.collectionView?.reloadData()
        }
        
        sections.add(section: charSection)
        sections.add(section: itemSection)
        
    }
    

}
