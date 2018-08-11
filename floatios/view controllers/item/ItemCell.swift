//
//  ItemCell.swift
//  floatios
//
//  Created by Alexander Skorulis on 2/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView
import FLScene

final class ItemCell: UICollectionViewCell, AutoSizeModelCell {
    var model: ItemModel? {
        didSet {
            if let m = model {
                self.nameLabel.text = m.ref.name
                self.quantityLabel.text = "\(m.quantity)"
            }
        }
    }
    static var sizingCell: ItemCell = ItemCell()
    typealias ModelType = ItemModel
    
    let nameLabel = UILabel()
    let quantityLabel = UILabel()
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(quantityLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.bottom.top.equalToSuperview().inset(10)
        }
        quantityLabel.snp.makeConstraints { (make) in
            make.right.bottom.top.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
