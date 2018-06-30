//
//  PlayerViewController.swift
//  floatios
//
//  Created by Alexander Skorulis on 29/6/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView

class PlayerViewController: UICollectionViewController {

    let game = GameController.instance
    let flowLayout = UICollectionViewFlowLayout();
    let sections:SKCVSectionCoordinator = SKCVSectionCoordinator()
    let actions:[CharacterAction] = [.sleep,.eat,.forage]
    
    init() {
        super.init(collectionViewLayout: flowLayout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(clazz: ActionCell.self)
        collectionView?.register(clazz: PlayerDetailsCell.self)
        
        let char = game.player.player.base
        
        
        let charSection = SKCVSectionController()
        charSection.fixedCellCount = 1
        charSection.cellForItemAt = PlayerDetailsCell.curriedDefaultCell(withModel: char)
        charSection.sizeForItemAt = PlayerDetailsCell.curriedCalculateSize(withModel: char)
        
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
        
        self.collectionView?.delegate = sections
        self.collectionView?.dataSource = sections
        
    }
    

}
