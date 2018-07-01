//
//  ReferenceController.swift
//  floatios
//
//  Created by Alexander Skorulis on 1/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKSwiftLib

class ReferenceController {

    let items:[String:ItemReferenceModel]
    
    init() {
        let food = ItemReferenceModel(name: "Food", description: "Something you can eat")
        let ether = ItemReferenceModel(name: "Ether", description: "Should link to lore article")
        
        let itemArray = [food,ether]
        items = itemArray.groupSingle { $0.name }
    }
    
}
