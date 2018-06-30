//
//  ArrayExtensions.swift
//  floatios
//
//  Created by Alexander Skorulis on 30/6/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit

extension Array {
    
    func getRow(indexPath:IndexPath) -> Element {
        return self[indexPath.row]
    }
    
    func sectionCount(collectionView:UICollectionView,section:Int) -> Int {
        return self.count
    }
    
}
