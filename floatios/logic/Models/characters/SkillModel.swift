//
//  SkillModel.swift
//  Common
//
//  Created by Alexander Skorulis on 25/6/18.
//

public class SkillModel:Codable {

    let type:SkillReferenceModel
    var level:Int
    var xp:Float
    
    public init(type:SkillReferenceModel) {
        self.type = type;
        self.level = 1
        self.xp = 0
    }
    
}

public class SkillListModel:Codable {
    
    var skills:[SkillModel]
    
    init() {
        self.skills = []
    }
    
    func findSkill(type:SkillType) -> SkillModel? {
        return self.skills.filter { $0.type.name == type}.first
    }
    
    func skillLevel(type:SkillType) -> Int {
        return findSkill(type: type)?.level ?? 0
    }
    
}
