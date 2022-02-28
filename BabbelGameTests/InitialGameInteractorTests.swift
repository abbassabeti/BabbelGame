//
//  InitialGameInteractorTests.swift
//  BabbelGameTests
//
//  Created by Abbas Sabeti on 27/02/2022.
//

import XCTest
@testable import BabbelGame

class InitialGameInteractorTests: XCTestCase {

    var interactor: InitialGameInteractorProtocol?
    let wordWorker = MockWordWorker()
    let checkStateWorker = MockCheckStateWorker()

    override func setUpWithError() throws {
        interactor = InitialGameInteractor(wordWorker: wordWorker, stateWorker: checkStateWorker)
    }

    override func tearDownWithError() throws {

    }

    func testIfPlayForAndWinWorks() throws {
        let notFinishGameEarlyExpectation = expectation(description: "Game finished early")
        notFinishGameEarlyExpectation.isInverted = true

        var spyDelegate = SpyInitialGameInteractorDelegate(gameIsDone: {
            notFinishGameEarlyExpectation.fulfill()
        })

        interactor?.delegate = spyDelegate

        guard let interactor = interactor else {
            fatalError("Failed in loading interactor")
        }

        for item in interactor.players.value {
            XCTAssertEqual(item.correctAnswers, 0)
            XCTAssertEqual(item.incorrectAnswers, 0)
        }
        for (index, item) in interactor.players.value.enumerated() {
            let initialCorrectCount = item.correctAnswers
            let initialIncorrectCount = item.incorrectAnswers
            wordWorker.needsCorrectPoint = true
            interactor.playFor(userIndex: index, meaning: "")
            XCTAssertEqual(item.correctAnswers, initialCorrectCount + 1)
            XCTAssertEqual(item.incorrectAnswers, initialIncorrectCount)
            wordWorker.needsCorrectPoint = false
            interactor.playFor(userIndex: index, meaning: "")
            XCTAssertEqual(item.correctAnswers, initialCorrectCount + 1)
            XCTAssertEqual(item.incorrectAnswers, initialIncorrectCount + 1)
        }

        wait(for: [notFinishGameEarlyExpectation], timeout: 2.0)

        checkStateWorker.needsToBeDone = true
        wordWorker.needsCorrectPoint = true

        let finishGameExpectation = expectation(description: "Game didn't finished when needed")

        spyDelegate = SpyInitialGameInteractorDelegate(gameIsDone: {
            finishGameExpectation.fulfill()
        })
        self.interactor?.delegate = spyDelegate

        interactor.playFor(userIndex: 0, meaning: "")

        wait(for: [finishGameExpectation], timeout: 2.0)

    }

    func testIfResetWorks() throws {

        guard let interactor = interactor else {
            fatalError("Failed in loading interactor")
        }

        for index in 0...3 {
            XCTAssertEqual(interactor.players.value[index].correctAnswers, 0)
            XCTAssertEqual(interactor.players.value[index].incorrectAnswers, 0)
        }

        wordWorker.needsCorrectPoint = true

        for index in 0...3 {
            interactor.playFor(userIndex: index, meaning: "")
            XCTAssertEqual(interactor.players.value[index].correctAnswers, 1)
            XCTAssertEqual(interactor.players.value[index].incorrectAnswers, 0)
            XCTAssertEqual(interactor.players.value[index].getNetScore(), 1)
        }

        wordWorker.needsCorrectPoint = false

        for index in 0...3 {
            interactor.playFor(userIndex: index, meaning: "")
            XCTAssertEqual(interactor.players.value[index].correctAnswers, 1)
            XCTAssertEqual(interactor.players.value[index].incorrectAnswers, 1)
            XCTAssertEqual(interactor.players.value[index].getNetScore(), 0)
        }

        interactor.resetGame()

        for index in 0...3 {
            XCTAssertEqual(interactor.players.value[index].correctAnswers, 0)
            XCTAssertEqual(interactor.players.value[index].incorrectAnswers, 0)
            XCTAssertEqual(interactor.players.value[index].getNetScore(), 0)
        }

    }

}
