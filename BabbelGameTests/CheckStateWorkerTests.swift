//
//  CheckStateWorkerTests.swift
//  BabbelGameTests
//
//  Created by Abbas Sabeti on 27/02/2022.
//

import XCTest
@testable import BabbelGame

class CheckStateWorkerTests: XCTestCase {
    var worker : CheckStateWorkerProtocol?
    
    override func setUpWithError() throws {
        worker = CheckStateWorker()
    }

    override func tearDownWithError() throws {
    }

    func testIfNegativeScoresWontWin() throws{
        let noWinnerExpectation = expectation(description: "There is a winner with negative points")
        noWinnerExpectation.isInverted = true
        guard let worker = worker else {
            fatalError("Failed to initialize worker")
        }
        let players: [Player] = [4,3,2,1].map {Player(name: "\($0)", correctAnswers: 0, incorrectAnswers: $0 * 5)}
        if let _ = worker.checkIfGameIsDone(players: players) {
            noWinnerExpectation.fulfill()
        }
        
        wait(for: [noWinnerExpectation], timeout: 2)
    }
    
    func testIfFirstPioneerPlayerWins() throws{
        let winnerExpectation = expectation(description: "First pioneer player wins")
        let initialNoWinnerExpectation = expectation(description: "No one wins with less than minimum score")
        initialNoWinnerExpectation.isInverted = true
        guard let worker = worker else {
            fatalError("Failed to initialize worker")
        }
        let players: [Player] = [0,0,0,1].map {Player(name: "\($0)", correctAnswers: $0 * (GameConstants.minimumWinnerScore - 1), incorrectAnswers: 0)}
        
        if let _ = worker.checkIfGameIsDone(players: players) {
            initialNoWinnerExpectation.fulfill()
        }
        players[3].incrementCorrectCount()
        if let _ = worker.checkIfGameIsDone(players: players) {
            winnerExpectation.fulfill()
        }
        
        wait(for: [winnerExpectation,initialNoWinnerExpectation], timeout: 2)
    }
}
