//
//  PlayerViewController.swift
//  floatios
//
//  Created by Alexander Skorulis on 29/6/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKCollectionView

class PlayerViewController: UICollectionViewController {

    let flowLayout = UICollectionViewFlowLayout();
    
    init() {
        super.init(collectionViewLayout: flowLayout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let sections:SKCVSectionCoordinator = SKCVSectionCoordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.delegate = sections
        self.collectionView?.dataSource = sections
    }
    

}
