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
            if let m = model {
                label.text = m.type.name.rawValue
                level.text = "\(m.level)"
            }
            
        }
    }
    
    private let label = UILabel()
    private let level = UILabel()
    private let progressBar = ProgressBar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(label)
        contentView.addSubview(self.progressBar)
        contentView.addSubview(level)
        
        self.progressBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10))
            make.height.equalTo(14)
        }
        
        level.snp.makeConstraints { (make) in
            make.right.top.equalToSuperview().inset(10)
            
        }
        
        label.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview().inset(10)
            make.bottom.equalTo(self.progressBar.snp.top).offset(-4)
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
