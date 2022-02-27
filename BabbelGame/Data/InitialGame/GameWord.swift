//
//  GameWord.swift
//  BabbelGame
//
//  Created by Abbas Sabeti on 26/02/2022.
//

import Foundation
import UIKit

class GameWord {
    let original : String
    let meaning: String
    let fakeMeanings: [String]
    var wrongMeaningIndex: Int = 0
    @Published var lastShownMeaning: String = ""
    
    init(original: String,meaning: String,fakeMeanings: [String]){
        self.original = original
        self.meaning = meaning
        self.fakeMeanings = fakeMeanings
        _ = getRandomMeaning()
    }
    
    func getRandomMeaning() -> String {
        let showWrongMeaning : Bool = Double.random(in: 0...1) < GameConstants.chanceOfWrongMeaning
        if (showWrongMeaning || lastShownMeaning == meaning){
            let meaning = fakeMeanings[wrongMeaningIndex]
            wrongMeaningIndex = (wrongMeaningIndex + 1) % fakeMeanings.count
            lastShownMeaning = meaning
            return meaning
        }else{
            lastShownMeaning = meaning
            return meaning
        }
    }
}
