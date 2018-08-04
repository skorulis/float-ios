//
//  SkillListViewController.swift
//  floatios
//
//  Created by Alexander Skorulis on 12/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView
import SKSwiftLib
import FLGame

class SkillListViewController: SKCVFlowLayoutCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.white

        let game = GameController.instance
        let player = game.player.player
        
        let allSkills = game.reference.skills.map {$0.value}
        let split = allSkills.splitArray { (ref) -> Bool in
            return player.base.hasSkill(skill: ref.name)
        }
        
        let activeSkills = split.passing.map { (ref) in
            return player.base.skills.findSkill(type: ref.name)!
        }
        
        let missingSkills = split.failing.map { SkillModel(type: $0)}
        
        let activeSection = SkillProgressCell.defaultSection(items: activeSkills, collectionView: collectionView!)
        let missingSection = SkillProgressCell.defaultSection(items: missingSkills, collectionView: collectionView!)
        SectionHeaderView.updateSectionHeader(section: missingSection, model: "Unavailable", kind: UICollectionElementKindSectionHeader, collectionView: collectionView!)
        
        self.sections.add(section: activeSection)
        self.sections.add(section: missingSection)
    }
    

}
