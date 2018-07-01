//
//  ActionCell.swift
//  floatios
//
//  Created by Alexander Skorulis on 29/6/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView
import SnapKit

final class ActionCell: UICollectionViewCell, AutoSizeModelCell {
    var model: CharacterAction? {
        didSet {
            self.label.text = model?.rawValue
        }
    }
    static var sizingCell: ActionCell = ActionCell()
    typealias ModelType = CharacterAction
    
    let label = UILabel()
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.contentView.backgroundColor = UIColor.blue
        
        label.textAlignment = .center
        label.backgroundColor = UIColor.brown
        
        self.contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
