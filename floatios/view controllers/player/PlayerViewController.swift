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
        
        let char = game.player.player.base
        let charSection = PlayerDetailsCell.defaultSection(object: char, collectionView: collectionView!)
        
        let getModel:(IndexPath) -> (CharacterAction?) = { (indexPath) -> CharacterAction? in
            return self.actions[indexPath.row]
        }
        let getCount:SectionCountBlock = { (UICollectionView,Int) -> Int in
            return self.actions.count
        }
        
        let itemSection = ActionCell.defaultSection(getModel: getModel,getCount:getCount, collectionView: collectionView!)
        itemSection.didSelectItemAt = {(collectionView,indexPath) in
            let action = self.actions[indexPath.row]
            self.game.player.performCharacterAction(action: action)
            self.collectionView?.reloadData()
        }
        
        sections.add(section: charSection)
        sections.add(section: itemSection)
        
    }
    

}
