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
import SKComponents

class ReferenceController {

    let items:[String:ItemReferenceModel]
    let story:[String:StoryReferenceModel]
    let skills:[SkillType:SkillReferenceModel]
    let actions:[ActionType:ActionReferenceModel]
    let dungeonTiles:[DungeonTileType:DungeonTileReferenceModel]
    let terrain:[TerrainType:TerrainReferenceModel]
    let monsters:[String:MonsterReferenceModel]
    
    init() {
        let itemArray = ReferenceController.makeItems()
        items = itemArray.groupSingle { $0.name }
        story = ReferenceController.makeStory().groupSingle { $0.key }
        skills = ReferenceController.makeSkills().groupSingle { $0.name }
        actions = ReferenceController.makeActions().groupSingle { $0.type }
        dungeonTiles = ReferenceController.makeDungeonTiles().groupSingle { $0.type }
        terrain = ReferenceController.makeTerrainTiles().groupSingle { $0.type }
        monsters = ReferenceController.readReferenceObjects(filename: "monsters").groupSingle { $0.name}
    }
    
    static func makeStory() -> [StoryReferenceModel] {
        let start = StoryReferenceModel(key: "start", story: "You open your eyes to unfamiliar surroundings with no memory of how you came to be here. You sit up and rub your head to try to remember, all you can think of is your name")
        let needSleep = StoryReferenceModel(key: "start_sleep", story: "At least you can remember that much, by the time you senses return a litt the sun is alread going down, you decide to sleep and see what you can find in the morning")
        
        
        return [start,needSleep]
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
        
        let dungeon = ActionReferenceModel(type: .dungeon, icon: FAKFontAwesome.fortAwesomeIcon(withSize: iconSize),
                                           reqs:[RequirementModel.time(value: 100),
                                                 RequirementModel.satiation(value: 10)])
        
        return [sleep,eat,forage,mine,lumberjack,explore,dungeon]
    }
    
    private static func makeDungeonTiles() -> [DungeonTileReferenceModel] {
        let wall = DungeonTileReferenceModel(type: .wall, canPass: false)
        let stairUp = DungeonTileReferenceModel(type:.stairsUp,canPass: true,actions:[.goUp])
        let stairDown = DungeonTileReferenceModel(type:.stairsDown,canPass: true,actions:[.goDown])
        return [wall,stairUp,stairDown]
    }
    
    private static func makeTerrainTiles() -> [TerrainReferenceModel] {
        let grass = TerrainReferenceModel(type: .grass,color: SKTheme.theme.color.nephritis)
        let dirt = TerrainReferenceModel(type: .dirt,color: SKTheme.theme.color.pumpkin)
        let floor = TerrainReferenceModel(type: .floor,color: SKTheme.theme.color.concrete)
        let water = TerrainReferenceModel(type: .water,color: SKTheme.theme.color.belizeHole)
        return [grass,dirt,floor,water]
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
    
    func getDungeonTile(type:DungeonTileType) -> DungeonTileReferenceModel {
        return dungeonTiles[type]!
    }
    
    func getDungeonTile(name:String) -> DungeonTileReferenceModel {
        let type = DungeonTileType.init(rawValue: name)!
        return getDungeonTile(type: type)
    }
    
    func getTerrain(type:TerrainType) -> TerrainReferenceModel {
        return terrain[type]!
    }
    
    func allActions() -> [ActionReferenceModel] {
        return actions.values.map { $0 }
    }
    
    func randomSkill() -> SkillReferenceModel {
        let all = Array(skills.values)
        let index = arc4random_uniform(UInt32(all.count))
        return all[Int(index)]
    }
    
    class func readReferenceObjects(filename:String) -> [MonsterReferenceModel] {
        do {
            let path = Bundle.main.path(forResource: filename, ofType: "json")!
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            let objects = try decoder.decode([MonsterReferenceModel].self, from: data)
            return objects
        } catch {
            
        }
        return []
    }
    
}
