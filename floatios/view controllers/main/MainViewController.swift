//
//  MainViewController.swift
//  floatios
//
//  Created by Alexander Skorulis on 8/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SnapKit
import FLGame

class MainViewController: UIViewController {

    let game = GameController.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let playerVC = PlayerViewController()
        let cityVC = CityViewController()
        let mapVC = Map3DViewController()
        
        let tab = UITabBarController()
        tab.viewControllers = [mapVC,playerVC,cityVC].map { UINavigationController(rootViewController: $0) }
        
        self.view.addSubview(tab.view)
        tab.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.addChildViewController(tab)
        
        GameController.instance.majorState.observers.add(object: self, self.gameStateChanged)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.game.player.player.base.name = "Alex"
        
        if self.game.majorState.playerHasName() {
            return
        }
        
        let story = game.reference.getStory(key: "start")
        let journal = game.player.addJournalEntry(story: story)
        let nextAction = StoryNextAction.showVC { CreatePlayerViewController() }
        
        let storyStart = StoryPieceViewController(story: journal, next:nextAction)
        
        let nav = UINavigationController(rootViewController: storyStart)
        self.present(nav, animated: false, completion: nil)
    }
    
    private func gameStateChanged(state:MajorStateController) {
        
    }

}
