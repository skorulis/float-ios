//
//  StoryPieceCell.swift
//  floatios
//
//  Created by Alexander Skorulis on 8/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView
import FLScene

final class StoryPieceCell: UICollectionViewCell, AutoSizeModelCell {
    
    static var sizingCell: StoryPieceCell = StoryPieceCell(frame: .zero)
    typealias ModelType = JournalEntry
    var model: JournalEntry? {
        didSet {
            if let m = model {
                self.label.text = model?.story.story
                self.avatar.showAvatar(avatar: m.avatar, size: 40)
            }
        }
    }
    
    let label = UILabel()
    let avatar = AvatarImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(label)
        self.contentView.addSubview(avatar)
        
        avatar.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().inset(8)
            make.width.equalTo(40)
        }
        
        label.numberOfLines = 0
        label.snp.makeConstraints { (make) in
            make.left.equalTo(avatar.snp.right).offset(8)
            make.right.top.bottom.equalToSuperview().inset(8)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
