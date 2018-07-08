//
//  TextFieldCell.swift
//  floatios
//
//  Created by Alexander Skorulis on 5/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SnapKit
import SKCollectionView
import CCTextFieldEffects

class TextFieldCellModel {
    let placeholder:String
    var text:String?
    
    init(placeholder:String) {
        self.placeholder = placeholder
    }
}

final class TextFieldCell: UICollectionViewCell, AutoSizeModelCell, ModelChangeFeedbackCell {
    
    var modelDidChangeBlock: ((TextFieldCellModel) -> ())?
    static var sizingCell: TextFieldCell = TextFieldCell()
    typealias ModelType = TextFieldCellModel
    var model: TextFieldCellModel? {
        didSet {
            
            self.textfield.placeholder = model?.placeholder
            self.textfield.text = model?.text
        }
    }
    
    let textfield:YokoTextField = YokoTextField(frame: CGRect(x: 0, y: 0, width: 320, height: 70))
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        buildView()
        buildLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildView() {
        self.contentView.addSubview(textfield)
        textfield.foregroundColor = UIColor.brown
        textfield.addTarget(self, action: #selector(textChanged(sender:)), for: .editingChanged)
    }
    
    func buildLayout() {
        textfield.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20))
            make.height.equalTo(70)
        }
    }
    
    @objc func textChanged(sender:Any) {
        print("TEst")
        guard let m = model else {return}
        m.text = textfield.text
        modelDidChangeBlock?(m)
    }
}
