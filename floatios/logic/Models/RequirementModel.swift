//
//  RequirementModel.swift
//  floatios
//
//  Created by Alexander Skorulis on 1/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit

enum RequirementType: String, Codable {
    case item
    case resource
    case skill
}

struct RequirementModel: Codable {
    
    let type:RequirementType
    let identifier:String
    let value:Int
    
    static func time(value:Int) -> RequirementModel {
        return RequirementModel(type: .resource, identifier: "time", value: value)
    }
    
    static func satiation(value:Int) -> RequirementModel {
        return RequirementModel(type: .resource, identifier: "satiation", value: value)
    }
    
}

class RequirementList: Codable {
    let requirements:[RequirementModel]
    
    init(requirements:[RequirementModel]) {
        self.requirements = requirements
    }
    
    static func empty() -> RequirementList {
        return RequirementList(requirements: [])
    }
}
