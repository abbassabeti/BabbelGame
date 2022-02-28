//
//  MockWordWorker.swift
//  BabbelGame
//
//  Created by Abbas Sabeti on 27/02/2022.
//

import Foundation

class MockWordWorker: WordsWorkerProtocol {
    var words: [GameWord] = []

    var lastIndex: Int = 0

    var needsCorrectPoint: Bool = false

    func getNextWord() -> GameWord? {
        lastIndex += 1
        guard lastIndex < words.count else {return nil}
        return words[lastIndex]
    }

    func checkIfCorrect(meaning: String) -> Bool {
        return needsCorrectPoint
    }

    func resetIndex() {
        lastIndex = 0
    }

}
