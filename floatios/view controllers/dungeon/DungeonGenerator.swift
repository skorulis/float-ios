//
//  DungeonGenerator.swift
//  floatios
//
//  Created by Alexander Skorulis on 19/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit
import GameplayKit

class DungeonGenerator {

    enum GeneratorType {
        case dungeon
        case outdoors
    }
    
    let dungeon:DungeonModel
    let size:Int
    let ref:ReferenceController
    
    init(size:Int,ref:ReferenceController,player:PlayerCharacterModel) {
        self.ref = ref
        let baseTerrain = ref.getTerrain(type: .grass)
        
        dungeon = DungeonModel(width: size, height: size, baseTerrain: baseTerrain,player:player)
        self.size = size
    }
    
    func generateDungeon(type:GeneratorType) -> DungeonModel {
        for x in 0..<size {
            for y in 0..<size {
                let node = dungeon.nodeAt(x: x, y: y)
                if (self.isEdge(x: x, y: y, size: size)) {
                    node?.fixture = ref.getDungeonTile(type: .wall)
                    node?.terrain = ref.getTerrain(type: .dirt)
                }
            }
        }
        
        if type == .dungeon {
            for _ in 0...10 {
                addRoom()
            }
            for _ in 0...2 {
                dungeon.playerNode.gridPosition = addStairs(up: true)
            }
            for _ in 0...2 {
                _ = addStairs(up: false)
            }
            for _ in 0...size/4 {
                addMonster()
            }
        } else if (type == .outdoors) {
            let allTerrain:[TerrainType] = [.grass,.water,.dirt]
            
            for y in 0..<dungeon.height {
                for x in 0..<dungeon.width {
                    let node = dungeon.nodeAt(x: x, y: y)
                    node?.terrain = ref.getTerrain(type: allTerrain.randomElement()!)
                }
            }
        }
        
        dungeon.updateConnectionGraph()
        
        return dungeon
    }
    
    func addRoom() {
        let x = arc4random_uniform(UInt32(size - 10))
        let y = arc4random_uniform(UInt32(size - 10))
        
        let width = arc4random_uniform(6) + 3
        let height = arc4random_uniform(6) + 3
        
        let endX = x+width
        let endY = y+height
        
        for i in x...endX {
            for j in y...endY {
                guard let node = dungeon.nodeAt(x: Int(i), y: Int(j)) else { continue }
                let isDoor = (i - x) != (j - y)
                if ( (i == x || j == y || i == endX || j == endY) && isDoor) {
                    node.fixture = ref.getDungeonTile(type: .wall)
                }
                node.terrain = ref.getTerrain(type: .floor)
            }
        }
    }
    
    func addStairs(up:Bool) -> vector_int2 {
        let pos = randomEmptyPoint()
        let node = dungeon.nodeAt(vec:pos)
        node?.fixture = up ? ref.getDungeonTile(type: .stairsUp) : ref.getDungeonTile(type: .stairsDown)
        return pos
    }
    
    func randomEmptyPoint() -> vector_int2 {
        let x = arc4random_uniform(UInt32(size - 2)) + 1
        let y = arc4random_uniform(UInt32(size - 2)) + 1
        
        let node = dungeon.nodeAt(x: Int(x), y: Int(y))!
        if node.fixture != nil {
            return randomEmptyPoint()
        }
        if node.beings.count > 0 {
            return randomEmptyPoint()
        }
        return vector_int2(Int32(x),Int32(y))
    }
    
    func addMonster() {
        let index: Int = Int(arc4random_uniform(UInt32(ref.monsters.count)))
        let monsterRef = Array(ref.monsters.values)[index]
        let monster = MonsterEntity(ref: monsterRef)
        monster.gridPosition = self.randomEmptyPoint()
        dungeon.addMonster(entity: monster)
    }
    
    func isEdge(x:Int,y:Int,size:Int) -> Bool { 
        return x == 0 || y == 0 || x == size - 1 || y == size - 1
    }
    
}
