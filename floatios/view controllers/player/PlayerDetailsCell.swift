//
//  PlayerDetailsCell.swift
//  floatios
//
//  Created by Alexander Skorulis on 30/6/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView
import FLScene

final class PlayerDetailsCell: UICollectionViewCell, SimpleModelCell, AutoSizeModelCell {
    
    var model: CharacterModel? {
        didSet {
            if let m = model {
                nameLabel.text = "\(m.name) \(m.ether) Ether"
                timeProgress.set(field: m.time)
                fullnessProgress.set(field: m.satiation)
                avatar.showAvatar(avatar: m.avatarIcon, size: 40)
            }
        }
    }
    static var sizingCell: PlayerDetailsCell = PlayerDetailsCell(frame:.zero)
    typealias ModelType = CharacterModel
    
    let nameLabel = UILabel()
    let timeProgress = ProgressBar()
    let fullnessProgress = ProgressBar()
    let avatar = AvatarImageView()
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        
        self.contentView.addSubview(avatar)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(timeProgress)
        self.contentView.addSubview(fullnessProgress)
        
        timeProgress.showLabel(title:"time")
        fullnessProgress.showLabel(title:"fullness")
        
        avatar.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatar.snp.right).offset(8)
            make.top.right.equalToSuperview().inset(10)
        }
        timeProgress.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
        }
        fullnessProgress.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameLabel)
            make.top.equalTo(timeProgress.snp.bottom).offset(4)
            make.bottom.equalToSuperview().inset(4)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
