//
//  PlayerDetailsCell.swift
//  floatios
//
//  Created by Alexander Skorulis on 30/6/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView

final class PlayerDetailsCell: UICollectionViewCell, SimpleModelCell, AutoSizeModelCell {
    
    var model: CharacterModel? {
        didSet {
            if let m = model {
                let text = "\(m.name)\nFullness: \(m.satiation.description), Time: \(m.time.description)\nEther: \(m.ether)"
                quickLabel.text = text;
                avatar.showAvatar(avatar: m.avatarIcon, size: 40)
            } else {
                quickLabel.text = ""
            }
            
        }
    }
    static var sizingCell: PlayerDetailsCell = PlayerDetailsCell(frame:.zero)
    typealias ModelType = CharacterModel
    
    let quickLabel = UILabel()
    let avatar = AvatarImageView()
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        
        self.quickLabel.numberOfLines = 0
        self.contentView.addSubview(avatar)
        self.contentView.addSubview(quickLabel)
        
        avatar.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(40)
        }
        
        quickLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatar.snp.right).offset(8)
            make.top.bottom.right.equalToSuperview().inset(10)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
