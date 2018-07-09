//
//  RequirementModel.swift
//  floatios
//
//  Created by Alexander Skorulis on 1/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit

class RequirementList: Codable {
    let requirements:[RequirementModel]
    
    init(requirements:[RequirementModel]) {
        self.requirements = requirements
    }
    
    static func empty() -> RequirementList {
        return RequirementList(requirements: [])
    }
}
