//
//  DungeonHeaderView.swift
//  floatios
//
//  Created by Alexander Skorulis on 21/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SnapKit
import SKComponents

class DungeonHeaderView: UIView {

    private let healthProgress = ProgressBar()
    private let manaProgress = ProgressBar()
    private let levelLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildView() {
        addSubview(healthProgress)
        addSubview(manaProgress)
        addSubview(levelLabel)
        
        healthProgress.showLabel(title: "health")
        manaProgress.showLabel(title: "mana")
        healthProgress.progressView.backgroundColor = SKTheme.theme.color.alizarin
        manaProgress.progressView.backgroundColor = SKTheme.theme.color.peterRiver
        levelLabel.font = UIFont.boldSystemFont(ofSize: 18)
        levelLabel.textAlignment = .center
        
        levelLabel.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.width.equalTo(levelLabel.snp.height)
        }
        
        healthProgress.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().inset(2)
            make.right.equalTo(levelLabel.snp.left).offset(-8)
        }
        manaProgress.snp.makeConstraints { (make) in
            make.left.right.equalTo(healthProgress)
            make.top.equalTo(healthProgress.snp.bottom).offset(2)
            make.bottom.equalToSuperview()
        }
    }
    
    func update(player:PlayerCharacterModel) {
        healthProgress.set(field: player.base.health)
        manaProgress.set(field: player.base.mana)
        self.levelLabel.text = "1"
    }

}
