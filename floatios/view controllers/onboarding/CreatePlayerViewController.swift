//
//  CreatePlayerViewController.swift
//  floatios
//
//  Created by Alexander Skorulis on 5/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView

class CreatePlayerViewController: SKCVFlowLayoutCollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create character"
        self.collectionView?.backgroundColor = UIColor.white
        
        let textFieldModel = TextFieldCellModel(placeholder: "Player name")
        let section = TextFieldCell.defaultSection(object: textFieldModel, collectionView: self.collectionView!)
        sections.add(section: section)
        
        let testModel = TextFieldCellModel(placeholder: "Experimental thingo")
        let section2 = TextFieldCell.defaultSection(object: testModel, collectionView: self.collectionView!)
        sections.add(section: section2)
        
        let cta = CTAButtonCell.defaultSection(object: "Create", collectionView: self.collectionView!)
        cta.didSelectItemAt = {(collectionView,indexPath) in
            print("Selected ")
        }
        sections.add(section: cta)
        
    }
}
