//
//  InitialGamePresenterTests.swift
//  BabbelGameTests
//
//  Created by Abbas Sabeti on 27/02/2022.
//

import XCTest
@testable import BabbelGame

class InitialGamePresenterTests: XCTestCase {
    

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testIfProceedGameWorks() throws {
        let playedExpectation = expectation(description: "Played for a specific player")
        let proceededExpectation = expectation(description: "Proceeded game")
        let resetExpectation = expectation(description: "Resetted game")
        let interactor: InitialGameInteractorProtocol = SpyInitialGameInteractor(playedForInfo: { playerIndex, meaning in
            playedExpectation.fulfill()
        }, proceededGame: {
                proceededExpectation.fulfill()
        }, resetedGame: {
            resetExpectation.fulfill()
        })
        let presenter : InitialGamePresenter = InitialGamePresenter(interactor: interactor)
        presenter.word = GameWord(original: "", meaning: "", fakeMeanings: ["X","Y"])
        presenter.startGame()
        wait(for: [proceededExpectation], timeout: 1.0)
        presenter.playFor(userIndex: 0)
        wait(for: [playedExpectation], timeout: 1.0)
        presenter.resetGame()
        wait(for: [resetExpectation], timeout: 1.0)
    }
}
