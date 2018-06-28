//
//  NonPlayerCharacterModel.swift
//  Common
//
//  Created by Alexander Skorulis on 25/6/18.
//

import Foundation

final class NonPlayerCharacterModel: Codable {

    let base:CharacterModel
    let id:String
    
    init() {
        base = CharacterModel()
        id = NSUUID().uuidString
    }
    
}
