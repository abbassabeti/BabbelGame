//
//  BabbelGameTests.swift
//  BabbelGameTests
//
//  Created by Abbas Sabeti on 26/02/2022.
//

import XCTest
@testable import BabbelGame

class PlayerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIfCorrectAnswerCounts() throws {
        let user: Player = Player(name: "Player A")
        for _ in 1...20 {
            let isCorrect = Double.random(in: 0...1) <= GameConstants.chanceOfWrongMeaning
            let previousCount = user.getNetScore()
            if isCorrect {
                user.incrementCorrectCount()
                XCTAssertEqual(user.getNetScore(), previousCount + 1)
            } else {
                user.incrementIncorrectCount()
                XCTAssertEqual(user.getNetScore(), previousCount - 1)
            }
        }
    }

    func testIfResetWorks() throws {
        let user: Player = Player(name: "Player A")
        for _ in 1...20 {
            let isCorrect = Double.random(in: 0...1) <= GameConstants.chanceOfWrongMeaning
            if isCorrect {
                user.incrementCorrectCount()
            } else {
                user.incrementIncorrectCount()
            }
        }
        XCTAssertGreaterThan(max(user.correctAnswers, user.incorrectAnswers), 0, "Increment failed")
        XCTAssertEqual(user.getNetScore(), user.correctAnswers - user.incorrectAnswers, "Wrong net score")
        user.reset()
        XCTAssertEqual(user.correctAnswers, 0, "Reset correct records failed")
        XCTAssertEqual(user.incorrectAnswers, 0, "Reset incorrect records failed")
        XCTAssertEqual(user.getNetScore(), 0, "Reset failed")
    }
}
