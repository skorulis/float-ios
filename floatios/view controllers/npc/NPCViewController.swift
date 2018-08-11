//
//  NPCViewController.swift
//  floatios
//
//  Created by Alexander Skorulis on 15/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView
import FLScene

class NPCViewController: SKCVFlowLayoutCollectionViewController {

    var npc:CharacterModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let game = GameController.instance
        
        self.collectionView?.backgroundColor = UIColor.white
        
        self.title = npc.name
        
        let playerChar = game.player.character()
        
        let trainingSection = SKCVSectionController()

        SectionHeaderView.updateSectionHeader(section: trainingSection, model: "Train skills", kind: UICollectionElementKindSectionHeader, collectionView: collectionView!)
        
        self.sections.preReloadBlock = { [unowned self] in
            let learnableSkills = self.npc.skills.trainable(into: playerChar.skills)
            let skillNames = learnableSkills.skills.map { $0.type.name.rawValue }
            ForwardNavigationCell.updateSection(section: trainingSection, items: skillNames, collectionView: self.collectionView!)
            trainingSection.didSelectItemAt = {[unowned self] (collectionView,indexPath) in
                let skill = learnableSkills.skills[indexPath.row]
                playerChar.skills.train(skill: skill)
                self.sections.reloadData()
            }
        }
        
        self.sections.add(section: trainingSection)
        
        self.sections.preReloadBlock?()
    }

}
