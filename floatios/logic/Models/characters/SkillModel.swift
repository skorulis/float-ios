//
//  SkillModel.swift
//  Common
//
//  Created by Alexander Skorulis on 25/6/18.
//

public enum SkillModelType: String, Codable {
    case gardening
}

public class SkillModel:Codable {

    let type:SkillModelType
    var value:Float
    
    public init(type:SkillModelType) {
        self.type = type;
        self.value = 1
    }
    
}
