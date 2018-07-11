//
//  StoryPieceViewController.swift
//  floatios
//
//  Created by Alexander Skorulis on 8/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView

enum StoryNextAction {
    case showVC(() -> (UIViewController))
    case dismiss
}

class StoryPieceViewController: SKCVFlowLayoutCollectionViewController {

    let story:JournalEntry
    let nextAction:StoryNextAction
    
    init(story:JournalEntry,next:StoryNextAction) {
        self.story = story
        self.nextAction = next
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
            switch self.nextAction {
            case .showVC(let block):
                let nextVC = block()
                self.navigationController?.pushViewController(nextVC, animated: true)
            case .dismiss:
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        }
        
        self.sections.add(section: section)
        self.sections.add(section: next)
        
    }

}
