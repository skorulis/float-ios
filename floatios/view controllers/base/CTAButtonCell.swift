//
//  CTAButtonCell.swift
//  floatios
//
//  Created by Alexander Skorulis on 6/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView

final class CTAButtonCell: UICollectionViewCell, AutoSizeModelCell {
    
    let label = UILabel()
    
    static var sizingCell: CTAButtonCell = CTAButtonCell(frame: .zero)
    typealias ModelType = String
    var model: String? {
        didSet {
            self.label.text = model
        }
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.contentView.backgroundColor = UIColor.gray
        self.label.textAlignment = .center
        self.label.textColor = UIColor.white
        
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            self.contentView.backgroundColor = isHighlighted ? UIColor.lightGray : UIColor.gray
        }
    }
}
