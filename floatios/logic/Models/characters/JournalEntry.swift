//
//  JournalEntry.swift
//  floatios
//
//  Created by Alexander Skorulis on 10/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit

struct JournalEntry: Codable {

    let avatar:String
    let story:StoryReferenceModel

    init(character:CharacterModel,story:StoryReferenceModel) {
        self.avatar = character.avatarIcon
        self.story = story
    }
}
