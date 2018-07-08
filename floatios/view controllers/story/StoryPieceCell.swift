//
//  StoryPieceCell.swift
//  floatios
//
//  Created by Alexander Skorulis on 8/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView

final class StoryPieceCell: UICollectionViewCell, AutoSizeModelCell {
    
    static var sizingCell: StoryPieceCell = StoryPieceCell(frame: .zero)
    typealias ModelType = StoryReferenceModel
    var model: StoryReferenceModel? {
        didSet {
            self.label.text = model?.story
        }
    }
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(label)
        label.numberOfLines = 0
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
