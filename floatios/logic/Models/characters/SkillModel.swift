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
    
    public init(type:SkillReferenceModel,level:Int = 0) {
        self.type = type;
        self.level = level
        self.xp = 0
    }
    
}

public class SkillListModel:Codable {
    
    var skills:[SkillModel]
    
    init(skills:[SkillModel] = []) {
        self.skills = skills
    }
    
    func add(skill:SkillModel) {
        if findSkill(type: skill.type.name) == nil {
            skills.append(skill)
        }
    }
    
    func findSkill(type:SkillType) -> SkillModel? {
        return self.skills.filter { $0.type.name == type}.first
    }
    
    func skillLevel(type:SkillType) -> Int {
        return findSkill(type: type)?.level ?? 0
    }
    
    func train(skill:SkillModel) {
        if let existing = findSkill(type: skill.type.name) {
            existing.level += 1
        } else {
            let modelNew = SkillModel(type: skill.type)
            add(skill: modelNew)
        }
    }
    
    func trainable(into:SkillListModel) -> SkillListModel {
        let skills = self.skills.filter { (skill) -> Bool in
            return into.skillLevel(type: skill.type.name) < skill.level
        }
        return SkillListModel(skills: skills)
    }
    
}
