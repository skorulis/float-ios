//
//  MonsterEntity.swift
//  floatios
//
//  Created by Alexander Skorulis on 29/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit

class MonsterEntity: GridEntity {

    let ref:MonsterReferenceModel
    
    init(ref:MonsterReferenceModel) {
        self.ref = ref
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
