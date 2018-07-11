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

final class ActionCell: UICollectionViewCell, SimpleModelCell {
    
    static func calculateSize(model: ActionReferenceModel?, collectionView: UICollectionView) -> CGSize {
        let spacing = CGFloat(10)
        let size = (collectionView.frame.size.width - 4 * spacing) / 3
        
        return CGSize(width: size, height: size)
    }
    
    var model: ActionReferenceModel? {
        didSet {
            if let m = model {
                let att:NSMutableAttributedString = m.icon.attributedString().mutableCopy() as! NSMutableAttributedString
                let a2 = NSAttributedString(string: "\n\(m.type.rawValue)")
                att.append(a2)
                self.label.attributedText = att
            }
            
        }
    }
    typealias ModelType = ActionReferenceModel
    
    let label = UILabel()
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        
        label.textAlignment = .center
        label.backgroundColor = UIColor.brown
        label.numberOfLines = 0
        
        self.contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
