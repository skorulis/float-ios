//
//  CityDetailsCell.swift
//  floatios
//
//  Created by Alexander Skorulis on 30/6/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView

final class CityDetailsCell: UICollectionViewCell, SimpleModelCell, AutoSizeModelCell {
    var model: CityModel? {
        didSet {
            label.text = model?.name
        }
    }
    static var sizingCell: CityDetailsCell = CityDetailsCell(frame:.zero)
    typealias ModelType = CityModel
    
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
