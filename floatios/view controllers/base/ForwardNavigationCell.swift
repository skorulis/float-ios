//
//  ForwardNavigationCell.swift
//  floatios
//
//  Created by Alexander Skorulis on 30/6/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView
import FontAwesomeKit

final class ForwardNavigationCell: UICollectionViewCell, AutoSizeModelCell {
    
    let label = UILabel()
    let chevron = UILabel()
    
    static var sizingCell: ForwardNavigationCell = ForwardNavigationCell()
    typealias ModelType = String
    var model: String? {
        didSet {
            self.label.text = model
        }
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        buildView()
        buildLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildView() {
        self.contentView.addSubview(label)
        label.text = "Something"
        //label.font = theme.font.title
        //label.textColor = theme.color.defaultText
        
        let icon = FAKFontAwesome.chevronRightIcon(withSize: 24)
        icon?.addAttribute(NSAttributedStringKey.foregroundColor.rawValue, value: UIColor.red)
        
        self.contentView.addSubview(chevron)
        chevron.attributedText = icon?.attributedString()
    }
    
    func buildLayout() {
        label.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(4)
        }
        
        chevron.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
        }
    }
    
}
