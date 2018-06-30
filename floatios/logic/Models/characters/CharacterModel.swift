//
//  CharacterModel.swift
//  App
//
//  Created by Alexander Skorulis on 26/6/18.
//

final public class CharacterModel: Codable {

    let name:String;
    let satiation:MaxValueField
    let time:MaxValueField
    let inventory:InventoryModel
    
    init(name:String="Fred") {
        self.name = name
        satiation = MaxValueField(maxValue: 100)
        time = MaxValueField(maxValue: 100)
        inventory = InventoryModel()
    }
    
}
