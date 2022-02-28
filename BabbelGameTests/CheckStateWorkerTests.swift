//
//  CheckStateWorkerTests.swift
//  BabbelGameTests
//
//  Created by Abbas Sabeti on 27/02/2022.
//

import XCTest
@testable import BabbelGame

class CheckStateWorkerTests: XCTestCase {
    var worker: CheckStateWorkerProtocol?

    override func setUpWithError() throws {
        worker = CheckStateWorker()
    }

    override func tearDownWithError() throws {
    }

    func testIfNegativeScoresWontWin() throws {
        guard let worker = worker else {
            fatalError("Failed to initialize worker")
        }
        let players: [Player] = [4, 3, 2, 1].map {
            Player(name: "\($0)", correctAnswers: 0, incorrectAnswers: $0 * 5)
        }
        let winner = worker.checkIfGameIsDone(players: players)
        XCTAssertNil(winner, "There is a winner with negative points")
    }

    func testIfFirstPioneerPlayerWins() throws {
        guard let worker = worker else {
            fatalError("Failed to initialize worker")
        }
        let players: [Player] = [0, 0, 0, 1].map {
            Player(name: "\($0)", correctAnswers: $0 * (GameConstants.minimumWinnerScore - 1), incorrectAnswers: 0)
        }

        XCTAssertNil(worker.checkIfGameIsDone(players: players), "No one wins with less than minimum score")

        players[3].incrementCorrectCount()

        XCTAssertNotNil(worker.checkIfGameIsDone(players: players), "First pioneer player wins")

    }
}
