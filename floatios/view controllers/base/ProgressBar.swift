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

    private let progressView = UIView()
    private var progressConstraint:Constraint?
    
    var progress:CGFloat {
        didSet {
            self.updateProgressConstraints()
        }
    }
    
    override init(frame: CGRect) {
        self.progress = 0.5
        super.init(frame: frame)
        self.addSubview(progressView)
        self.updateProgressConstraints()
        self.backgroundColor = SKTheme.theme.color.asbestos
        self.progressView.backgroundColor = SKTheme.theme.color.carrot
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
    
}
