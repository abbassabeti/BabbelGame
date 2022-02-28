//
//  MockInitialGamePresenter.swift
//  BabbelGame
//
//  Created by Abbas Sabeti on 27/02/2022.
//

import Foundation
import UIKit

class MockInitialGamePresenter: InitialGamePresenterProtocol {
    var interactor: InitialGameInteractorProtocol

    var router: InitialGameRouterProtocol

    var players: [Player]

    var winner: Player?

    var word: GameWord?

    init(interactor: InitialGameInteractorProtocol, router: InitialGameRouterProtocol) {
        self.interactor = interactor
        self.router = router
        self.players = []
    }

    func playFor(userIndex: Int) {
        interactor.playFor(userIndex: userIndex, meaning: "")
    }

    func startGame() {
        interactor.proceedGame()
    }

    func resetGame() {
        interactor.resetGame()
    }

}
