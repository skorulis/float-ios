//
//  StatProgressCell.swift
//  floatios
//
//  Created by Alexander Skorulis on 2/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView

struct StatProgressViewModel {
    let name:String
    let value:Int
}

final class StatProgressCell: UICollectionViewCell, AutoSizeModelCell {
    var model: StatProgressViewModel? {
        didSet {
            if let m = model {
                self.label.text = "\(m.name) - \(m.value)"
            }
        }
    }
    static var sizingCell: StatProgressCell = StatProgressCell()
    typealias ModelType = StatProgressViewModel
    
    let label = UILabel()
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        
        self.contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
