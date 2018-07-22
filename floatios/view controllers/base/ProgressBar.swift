//
//  ProgressBar.swift
//  floatios
//
//  Created by Alexander Skorulis on 16/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SnapKit
import SKComponents

class ProgressBar: UIView {

    let progressView = UIView()
    private let label = UILabel() //Optional label
    private var progressConstraint:Constraint?
    
    var title:String?
    
    var progress:CGFloat {
        didSet {
            self.updateProgressConstraints()
        }
    }
    
    override init(frame: CGRect) {
        self.progress = 0.5
        super.init(frame: frame)
        self.addSubview(progressView)
        self.addSubview(label)
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.white
        
        self.updateProgressConstraints()
        self.backgroundColor = SKTheme.theme.color.asbestos
    }
    
    func showLabel(title:String?) {
        self.title = title
        self.progressView.backgroundColor = SKTheme.theme.color.carrot
        self.label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(2)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateProgressConstraints() {
        progressView.snp.remakeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(self.progress)
        }
    }
    
    func set(field:MaxValueField) {
        let value = CGFloat(field.value) / CGFloat(field.maxValue)
        self.progress = value
        if let t = self.title {
            label.text = "\(t): \(field.description)"
        } else {
            label.text = field.description
        }
    }
    
}
