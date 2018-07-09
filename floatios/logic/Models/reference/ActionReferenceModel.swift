//
//  ActionReferenceModel.swift
//  floatios
//
//  Created by Alexander Skorulis on 9/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit

public enum ActionType: String, Codable {
    case forage //Find food
    case mine //Find minerals
    case lumberjack //Get wood
    case sleep
    case eat //Should really be use item and be under a separate case
}

public enum RequirementType: String, Codable {
    case item
    case resource
    case skill
}

public struct RequirementModel: Codable {
    
    public let type:RequirementType
    public let identifier:String
    public let value:Int
    
    public static func time(value:Int) -> RequirementModel {
        return RequirementModel(type: .resource, identifier: "time", value: value)
    }
    
    public static func satiation(value:Int) -> RequirementModel {
        return RequirementModel(type: .resource, identifier: "satiation", value: value)
    }
    
    public static func item(name:String,value:Int) -> RequirementModel {
        return RequirementModel(type: .item, identifier: name, value: value)
    }
    
    public static func skill(type:SkillType,level:Int = 1) -> RequirementModel {
        return RequirementModel(type: .skill, identifier: type.rawValue, value: level)
    }
    
}

public struct ActionReferenceModel: Codable {

    public let type:ActionType
    public let requirements:[RequirementModel]
    
    public init(type:ActionType,reqs:[RequirementModel] = []) {
        self.type = type
        self.requirements = reqs
    }
    
}
