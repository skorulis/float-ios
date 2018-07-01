//
//  SectionHeaderView.swift
//  floatios
//
//  Created by Alexander Skorulis on 1/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SnapKit
import SKCollectionView

final class SectionHeaderView: UICollectionReusableView, AutoSizeModelCell {
    
    static var sizingCell: SectionHeaderView = SectionHeaderView()
    typealias ModelType = String
    var model: String? {
        didSet {
            self.label.text = model
        }
    }
    
    let label = UILabel()
    let rightButton = UIButton()
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        buildView()
        buildLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildView() {
        label.textAlignment = .center
        
        self.addSubview(label)
        self.addSubview(rightButton)
    }
    
    func buildLayout() {
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        rightButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
        }
    }
    
}
