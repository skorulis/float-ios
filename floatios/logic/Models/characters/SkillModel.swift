//
//  SkillModel.swift
//  Common
//
//  Created by Alexander Skorulis on 25/6/18.
//

public class SkillModel:Codable {

    let type:SkillReferenceModel
    var value:Float
    
    public init(type:SkillReferenceModel) {
        self.type = type;
        self.value = 1
    }
    
}
