//
//  CTAButtonCell.swift
//  floatios
//
//  Created by Alexander Skorulis on 6/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView
import SKComponents

class CTAButtonModel {
    var text:String
    var enabled:Bool = true
    
    init(text:String) {
        self.text = text;
    }
    
}

final class CTAButtonCell: UICollectionViewCell, AutoSizeModelCell {
    
    let label = UILabel()
    
    static var sizingCell: CTAButtonCell = CTAButtonCell(frame: .zero)
    typealias ModelType = CTAButtonModel
    var model: CTAButtonModel? {
        didSet {
            self.label.text = model?.text
            updateState()
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
        updateState()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            updateState()
        }
    }
    
    private func currentBackgroundColor() -> UIColor {
        guard let m = self.model else {return UIColor.blue}
        if (!m.enabled) {
            return disabledColor
        }
        return isHighlighted ? highlightColor : enabledColor
    }
    
    private func updateState() {
        let color = currentBackgroundColor()
        if (color != self.contentView.backgroundColor) {
            self.contentView.backgroundColor = color
        }
    }
    
    var disabledColor:UIColor {
        return UIColor.lightGray
    }
    
    var enabledColor:UIColor {
        return SKTheme.theme.color.emerald
    }
    
    var highlightColor:UIColor {
        return SKTheme.theme.color.emerald.lighterColor(removeSaturation: 0.4)
    }
}
