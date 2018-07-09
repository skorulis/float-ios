//
//  AvatarEmojiCellCollectionViewCell.swift
//  floatios
//
//  Created by Alexander Skorulis on 9/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView

final class AvatarEmojiCellCollectionViewCell: UICollectionViewCell, AutoSizeModelCell {
    
    static var sizingCell: AvatarEmojiCellCollectionViewCell = AvatarEmojiCellCollectionViewCell(frame: .zero)
    typealias ModelType = String
    var model: String? {
        didSet {
            if let avatar = model {
                imageView.showAvatar(avatar: avatar, size: fixedSize)
            }
            
        }
    }
    
    let imageView = AvatarImageView()
    private let fixedSize = CGFloat(40)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
