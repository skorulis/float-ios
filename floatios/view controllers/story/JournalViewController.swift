//
//  StoryViewController.swift
//  floatios
//
//  Created by Alexander Skorulis on 8/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView
import FLGame

class JournalViewController: SKCVFlowLayoutCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Journal"
        self.collectionView?.backgroundColor = UIColor.white

        let game = GameController.instance
        let stories = game.player.player.journal
        
        let section = StoryPieceCell.defaultSection(items: stories, collectionView: self.collectionView!)
        self.sections.add(section: section)
        
    }

}
