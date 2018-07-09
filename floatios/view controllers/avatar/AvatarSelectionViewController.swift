//
//  AvatarSelectionViewController.swift
//  floatios
//
//  Created by Alexander Skorulis on 9/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView

class AvatarSelectionViewController: SKCVFlowLayoutCollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let icons = "😀😂🤣😃😅😆😊😎😍😗😚🤗🤩🤔😐🙄😏😣😮😫😌😜🤤☹😖😤😦👨👷🤴👸👰🤵👤".map { String($0) }
        
        let chars = AvatarEmojiCellCollectionViewCell.defaultSection(items: icons, collectionView: self.collectionView!)
        
        
        self.sections.add(section: chars)
        
    }
    
}
