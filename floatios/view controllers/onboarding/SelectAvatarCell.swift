//
//  SelectAvatarCell.swift
//  floatios
//
//  Created by Alexander Skorulis on 10/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView

final class SelectAvatarCell: UICollectionViewCell, AutoSizeModelCell {

    static var sizingCell: SelectAvatarCell = SelectAvatarCell(frame: .zero)
    typealias ModelType = String
    var model: String? {
        didSet {
            if let avatar = model {
                imageView.showAvatar(avatar: avatar, size: 40)
            }
            
        }
    }
    
    let imageView = AvatarImageView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(label)
        label.text = "What do you look like"
        
        imageView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.height.equalTo(40)
            make.left.equalToSuperview()
        }
        
        label.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(imageView.snp.right).offset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
