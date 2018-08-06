//
//  ReferenceController.swift
//  floatios
//
//  Created by Alexander Skorulis on 1/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import SKSwiftLib

#if os(iOS)
//import FontAwesomeKit
import SKComponents
#endif

public class ReferenceController {

    public let items:[String:ItemReferenceModel]
    public let story:[String:StoryReferenceModel]
    public let skills:[SkillType:SkillReferenceModel]
    public let actions:[ActionType:ActionReferenceModel]
    public let dungeonTiles:[DungeonTileType:DungeonTileReferenceModel]
    public let terrain:[TerrainType:TerrainReferenceModel]
    public let monsters:[String:MonsterReferenceModel]
    
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
        
        var sleep = ActionReferenceModel(type: .sleep)
        
        var eat = ActionReferenceModel(type: .eat,
                                       reqs:[RequirementModel.time(value: 5),
                                            RequirementModel.item(name: "Food", value: 1)])
        
        var explore = ActionReferenceModel(type: .explore,
                                           reqs:[RequirementModel.time(value: 30),
                                                 RequirementModel.satiation(value: 10)])
        
        var forage = ActionReferenceModel(type: .forage,
                                          reqs: [RequirementModel.skill(type: .foraging),
                                                 RequirementModel.time(value: 10),
                                                 RequirementModel.satiation(value: 5)])
        
        var mine = ActionReferenceModel(type: .mine,
                                        reqs: [RequirementModel.skill(type: .mining),
                                               RequirementModel.time(value: 20),
                                               RequirementModel.satiation(value: 10)])
        
        var lumberjack = ActionReferenceModel(type: .lumberjack,
                                              reqs:[RequirementModel.skill(type: .lumberjacking),
                                                    RequirementModel.time(value: 20),
                                                    RequirementModel.satiation(value: 10)])
        
        var dungeon = ActionReferenceModel(type: .dungeon,
                                           reqs:[RequirementModel.time(value: 100),
                                                 RequirementModel.satiation(value: 10)])
        
        #if os(iOS)
        /*let iconSize = CGFloat(30)
        sleep.icon = FAKFontAwesome.moonOIcon(withSize: iconSize)
        eat.icon = FAKFontAwesome.appleIcon(withSize: iconSize)
        explore.icon = FAKFontAwesome.binocularsIcon(withSize: iconSize)
        forage.icon = FAKFontAwesome.pawIcon(withSize: iconSize)
        mine.icon = FAKFontAwesome.wrenchIcon(withSize: iconSize)
        lumberjack.icon = FAKFontAwesome.treeIcon(withSize: iconSize)
        dungeon.icon = FAKFontAwesome.fortAwesomeIcon(withSize: iconSize)*/
        #endif
        
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
        water.normalTexture = UIImage(named: "terrasses_water_normal")
        let void = TerrainReferenceModel(type: .void,color: UIColor.black)
        let redRock = TerrainReferenceModel(type: .redRock, color:UIColor.orange)
        
        return [grass,dirt,floor,water,void,redRock]
    }
    
    public func getItem(name:String) -> ItemReferenceModel {
        return items[name]!
    }
    
    public func getStory(key:String) -> StoryReferenceModel {
        return story[key]!
    }
    
    public func getSkill(type:SkillType) -> SkillReferenceModel {
        return skills[type]!
    }
    
    public func getAction(type:ActionType) -> ActionReferenceModel {
        return actions[type]!
    }
    
    public func getDungeonTile(type:DungeonTileType) -> DungeonTileReferenceModel {
        return dungeonTiles[type]!
    }
    
    public func getDungeonTile(name:String) -> DungeonTileReferenceModel {
        let type = DungeonTileType.init(rawValue: name)!
        return getDungeonTile(type: type)
    }
    
    public func getTerrain(type:TerrainType) -> TerrainReferenceModel {
        return terrain[type]!
    }
    
    public func allActions() -> [ActionReferenceModel] {
        return actions.values.map { $0 }
    }
    
    public func randomSkill() -> SkillReferenceModel {
        let all = Array(skills.values)
        let index = arc4random_uniform(UInt32(all.count))
        return all[Int(index)]
    }
    
    public class func readReferenceObjects(filename:String) -> [MonsterReferenceModel] {
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
