//
//  InitialGamePresenter.swift
//  BabbelGame
//
//  Created by Abbas Sabeti on 26/02/2022.
//

import Foundation
import Combine

protocol InitialGamePresenterProtocol: ObservableObject {
    var players: [Player] {get}
    var winner: Player? {get}
    var word: GameWord? {get}

    var interactor: InitialGameInteractorProtocol {get}

    func playFor(userIndex: Int)
    func startGame()
    func resetGame()
}

class InitialGamePresenter: InitialGamePresenterProtocol {
    @Published var players: [Player] = []
    @Published var winner: Player?
    @Published var word: GameWord?

    var interactor: InitialGameInteractorProtocol
    var cancellables = Set<AnyCancellable>()

    init(interactor: InitialGameInteractorProtocol) {
        self.interactor = interactor
        self.interactor.delegate = self

        self.interactor.players.sink { players in
            self.players = players
        }.store(in: &cancellables)

        self.interactor.word.sink { word in
            self.word = word
        }.store(in: &cancellables)
    }

    func playFor(userIndex: Int) {
        guard winner == nil else {return}
        guard let meaning = word?.lastShownMeaning else {return}
        interactor.playFor(userIndex: userIndex, meaning: meaning)
    }

    func startGame() {
        interactor.proceedGame()
    }
    func resetGame() {
        winner = nil
        interactor.resetGame()
    }
}

extension InitialGamePresenter: InitialGameInteractorDelegate {
    func declareWinner(user: Player) {
        winner = user
    }
}
