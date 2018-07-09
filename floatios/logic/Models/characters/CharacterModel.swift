//
//  CharacterModel.swift
//  App
//
//  Created by Alexander Skorulis on 26/6/18.
//

final public class CharacterModel: Codable {

    var name:String;
    let satiation:MaxValueField
    let time:MaxValueField
    var ether:Int
    let inventory:InventoryModel
    
    init(name:String="") {
        self.name = name
        satiation = MaxValueField(maxValue: 100)
        time = MaxValueField(maxValue: 100)
        ether = 100
        inventory = InventoryModel()
    }
    
    func hasResource(name:String,quantity:Int) -> Bool {
        return self.resourceQuantity(name: name) >= quantity
    }
    
    func resourceQuantity(name:String) -> Int {
        if (name == "satiation") {
            return satiation.value
        } else if (name == "time") {
            return time.value
        } else if (name == "ether") {
            return ether
        }
        return 0 //Shouldn't happen
    }
    
    func takeResource(name:String,quantity:Int) {
        if (name == "satiation") {
            satiation -= quantity
        } else if (name == "time") {
            time -= quantity
        } else if (name == "ether") {
            ether -= quantity
        }
    }
    
}
