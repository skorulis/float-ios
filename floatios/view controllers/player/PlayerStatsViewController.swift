//
//  PlayerStatsViewController.swift
//  floatios
//
//  Created by Alexander Skorulis on 2/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView
import FLGame

class PlayerStatsViewController: SKCVFlowLayoutCollectionViewController {
    
    let player:PlayerCharacterModel
    
    init(player:PlayerCharacterModel) {
        self.player = player
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.white
        self.title = "Statistics"
        
        let actionStats = player.stats.actionTimeStats.map { (key,value) -> StatProgressViewModel in
            return StatProgressViewModel(name: key, value: value)
        }
        
        let section = StatProgressCell.defaultSection(items: actionStats, collectionView: collectionView!)
        self.sections.add(section: section)
        
    }

}
