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
    let story:[String:StoryReferenceModel]
    
    init() {
        let itemArray = ReferenceController.makeItems()
        items = itemArray.groupSingle { $0.name }
        story = ReferenceController.makeStory().groupSingle { $0.key }
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
    
    func getItem(name:String) -> ItemReferenceModel {
        return items[name]!
    }
    
    func getStory(key:String) -> StoryReferenceModel {
        return story[key]!
    }
    
}
