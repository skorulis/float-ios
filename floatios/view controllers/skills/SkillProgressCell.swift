//
//  SkillProgressCell.swift
//  floatios
//
//  Created by Alexander Skorulis on 12/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView

final class SkillProgressCell: UICollectionViewCell, AutoSizeModelCell {
    
    static var sizingCell: SkillProgressCell = SkillProgressCell(frame: .zero)
    typealias ModelType = SkillModel
    var model: SkillModel? {
        didSet {
            label.text = model?.type.name.rawValue
        }
    }
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
