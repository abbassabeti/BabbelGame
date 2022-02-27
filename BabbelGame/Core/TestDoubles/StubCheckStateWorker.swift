//
//  MockCheckStateWorker.swift
//  BabbelGame
//
//  Created by Abbas Sabeti on 27/02/2022.
//

import Foundation

class MockCheckStateWorker : CheckStateWorkerProtocol {
    
    var needsToBeDone: Bool = false
    func checkIfGameIsDone(players: [Player]) -> Player? {
        return needsToBeDone ? Player(name: "", correctAnswers: 0, incorrectAnswers: 0) : nil
    }
}
