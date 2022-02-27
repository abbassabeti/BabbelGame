//
//  Word.swift
//  BabbelGame
//
//  Created by Abbas Sabeti on 26/02/2022.
//

import Foundation

struct Word : Codable {
    let original : String
    let meaning: String
    
    enum CodingKeys: String, CodingKey {
        case original = "text_eng"
        case meaning = "text_spa"
    }
}
