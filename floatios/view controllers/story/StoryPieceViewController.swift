//
//  StoryPieceViewController.swift
//  floatios
//
//  Created by Alexander Skorulis on 8/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView

class StoryPieceViewController: SKCVFlowLayoutCollectionViewController {

    let story:JournalEntry
    let nextVC:() -> (UIViewController)
    
    init(story:JournalEntry,nextVC:@escaping () -> (UIViewController)) {
        self.story = story
        self.nextVC = nextVC
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.white

        let section = StoryPieceCell.defaultSection(object: story, collectionView: self.collectionView!)
        
        let next = CTAButtonCell.defaultSection(object: CTAButtonModel(text: "Next"), collectionView: self.collectionView!)
        next.didSelectItemAt = {[unowned self] (collectionView,indexPath) in
            let next = self.nextVC()
            self.navigationController?.pushViewController(next, animated: true)
        }
        
        self.sections.add(section: section)
        self.sections.add(section: next)
        
    }

}
