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
    
    let game = GameController.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create character"
        self.collectionView?.backgroundColor = UIColor.white
        
        let buttonModel = CTAButtonModel(text: "Create")
        let textFieldModel = TextFieldCellModel(placeholder: "Player name")
        
        buttonModel.enabled = false
        let cta = CTAButtonCell.defaultSection(object: buttonModel, collectionView: self.collectionView!)
        cta.didSelectItemAt = {[unowned self] (collectionView,indexPath) in
            print("Selected ")
            self.game.player.player.base.name = textFieldModel.text!
            self.game.majorState.fireStateChange()
        }
        
        
        let section = TextFieldCell.defaultSection(object: textFieldModel, collectionView: self.collectionView!)
        section.willDisplayCell = TextFieldCell.willDisplayCellBlock(change: { (model) in
            buttonModel.enabled = (model.text?.count ?? 0) > 0
            self.sections.reload(section: cta)
        })
        sections.add(section: section)
        
        let testModel = TextFieldCellModel(placeholder: "Experimental thingo")
        let section2 = TextFieldCell.defaultSection(object: testModel, collectionView: self.collectionView!)
        sections.add(section: section2)
        
        sections.add(section: cta)
        
    }
}
