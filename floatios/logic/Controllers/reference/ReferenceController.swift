//
//  ReferenceController.swift
//  floatios
//
//  Created by Alexander Skorulis on 1/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import SKSwiftLib
import FontAwesomeKit

class ReferenceController {

    let items:[String:ItemReferenceModel]
    let story:[String:StoryReferenceModel]
    let skills:[SkillType:SkillReferenceModel]
    let actions:[ActionType:ActionReferenceModel]
    
    init() {
        let itemArray = ReferenceController.makeItems()
        items = itemArray.groupSingle { $0.name }
        story = ReferenceController.makeStory().groupSingle { $0.key }
        skills = ReferenceController.makeSkills().groupSingle { $0.name }
        actions = ReferenceController.makeActions().groupSingle { $0.type }
    }
    
    static func makeStory() -> [StoryReferenceModel] {
        let start = StoryReferenceModel(key: "start", story: "You open your eyes to unfamiliar surroundings with no memory of how you came to be here. You sit up and rub your head to try to remember, all you can think of is your name")
        
        return [start]
    }
    
    static func makeItems() -> [ItemReferenceModel] {
        let food = ItemReferenceModel(name: "Food", description: "Something you can eat")
        let ether = ItemReferenceModel(name: "Ether", description: "Should link to lore article")
        let minerals = ItemReferenceModel(name: "Minerals", description: "Generic minerals")
        let wood = ItemReferenceModel(name: "Wood", description: "Generic wood")
        
        return [food,ether,minerals,wood]
    }
    
    static func makeSkills() -> [SkillReferenceModel] {
        return [SkillReferenceModel(name: .foraging),SkillReferenceModel(name: .lumberjacking),SkillReferenceModel(name: .mining)]
    }
    
    static func makeActions() -> [ActionReferenceModel] {
        let iconSize = CGFloat(30)
        let sleep = ActionReferenceModel(type: .sleep, icon: FAKFontAwesome.moonOIcon(withSize: iconSize))
        let eat = ActionReferenceModel(type: .eat,icon: FAKFontAwesome.appleIcon(withSize: iconSize),
                                       reqs:[RequirementModel.time(value: 5),
                                            RequirementModel.item(name: "Food", value: 1)])
        
        let explore = ActionReferenceModel(type: .explore, icon: FAKFontAwesome.binocularsIcon(withSize: iconSize),
                                           reqs:[RequirementModel.time(value: 30),
                                                 RequirementModel.satiation(value: 10)])
        
        let forage = ActionReferenceModel(type: .forage, icon: FAKFontAwesome.pawIcon(withSize: iconSize),
                                          reqs: [RequirementModel.skill(type: .foraging),
                                                 RequirementModel.time(value: 10),
                                                 RequirementModel.satiation(value: 5)])
        
        let mine = ActionReferenceModel(type: .mine, icon: FAKFontAwesome.wrenchIcon(withSize: iconSize),
                                        reqs: [RequirementModel.skill(type: .mining),
                                               RequirementModel.time(value: 20),
                                               RequirementModel.satiation(value: 10)])
        
        let lumberjack = ActionReferenceModel(type: .lumberjack, icon: FAKFontAwesome.treeIcon(withSize: iconSize),
                                              reqs:[RequirementModel.skill(type: .lumberjacking),
                                                    RequirementModel.time(value: 20),
                                                    RequirementModel.satiation(value: 10)])
        
        return [sleep,eat,forage,mine,lumberjack,explore]
    }
    
    func getItem(name:String) -> ItemReferenceModel {
        return items[name]!
    }
    
    func getStory(key:String) -> StoryReferenceModel {
        return story[key]!
    }
    
    func getSkill(type:SkillType) -> SkillReferenceModel {
        return skills[type]!
    }
    
    func getAction(type:ActionType) -> ActionReferenceModel {
        return actions[type]!
    }
    
    func allActions() -> [ActionReferenceModel] {
        return actions.values.map { $0 }
    }
    
}
