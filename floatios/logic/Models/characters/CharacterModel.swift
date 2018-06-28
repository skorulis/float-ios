//
//  CharacterModel.swift
//  App
//
//  Created by Alexander Skorulis on 26/6/18.
//

final class CharacterModel: Codable {

    let name:String = "Fred"
    let satiation:MaxValueField
    let time:MaxValueField
    let inventory:InventoryModel
    
    init() {
        satiation = MaxValueField(maxValue: 100)
        time = MaxValueField(maxValue: 100)
        inventory = InventoryModel()
    }
    
}
