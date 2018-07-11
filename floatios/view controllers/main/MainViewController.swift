//
//  MainViewController.swift
//  floatios
//
//  Created by Alexander Skorulis on 8/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    let game = GameController.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let vc = PlayerViewController()
        let nav = UINavigationController(rootViewController: vc)
        self.view.addSubview(nav.view)
        nav.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.addChildViewController(nav)
        
        GameController.instance.majorState.observers.add(object: self, self.gameStateChanged)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.game.majorState.playerHasName() {
            return
        }
        
        let story = game.reference.getStory(key: "start")
        let journal = game.player.addJournalEntry(story: story)
        let storyStart = StoryPieceViewController(story: journal) { () -> (UIViewController) in
            return CreatePlayerViewController()
        }
        
        let nav = UINavigationController(rootViewController: storyStart)
        self.present(nav, animated: false, completion: nil)
    }
    
    private func gameStateChanged(state:MajorStateController) {
        if let _ = self.presentedViewController {
            self.dismiss(animated: true, completion: nil)
        }
    }

}
