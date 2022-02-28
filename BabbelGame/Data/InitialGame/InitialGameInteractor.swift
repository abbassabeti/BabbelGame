//
//  InitialGameInteractor.swift
//  BabbelGame
//
//  Created by Abbas Sabeti on 26/02/2022.
//

import Foundation
import Combine

protocol InitialGameInteractorProtocol: Any {
    var delegate: InitialGameInteractorDelegate? {get set}
    var players: CurrentValueSubject<[Player], Never> {get}
    var word: CurrentValueSubject<GameWord?, Never> {get}
    func playFor(userIndex: Int, meaning: String)
    func proceedGame()
    func resetGame()
}

protocol InitialGameInteractorDelegate: AnyObject {
    func declareWinner(user: Player)
}

final class InitialGameInteractor: InitialGameInteractorProtocol {

    var wordWorker: WordsWorkerProtocol

    var stateWorker: CheckStateWorkerProtocol

    weak var delegate: InitialGameInteractorDelegate?

    private(set) var players: CurrentValueSubject<[Player], Never> = .init([])
    private(set) var word: CurrentValueSubject<GameWord?, Never> = .init(nil)

    init(wordWorker: WordsWorkerProtocol, stateWorker: CheckStateWorkerProtocol) {
        self.wordWorker = wordWorker
        self.stateWorker = stateWorker
        self.providePlayers()
    }

    func playFor(userIndex: Int, meaning: String) {
        let isCorrect = wordWorker.checkIfCorrect(meaning: meaning)
        if isCorrect {
            players.value[userIndex].incrementCorrectCount()
        } else {
            players.value[userIndex].incrementIncorrectCount()
        }
        guard let winner = stateWorker.checkIfGameIsDone(players: players.value) else {
            proceedGame()
            return
        }
        delegate?.declareWinner(user: winner)
    }

    private func providePlayers() {
        self.players.send(
            ["A", "B", "C", "D"].map({
                return Player(name: "Player \($0)", correctAnswers: 0, incorrectAnswers: 0)
            })
        )
    }

    func proceedGame() {
        self.word.send(self.wordWorker.getNextWord())
    }

    func resetGame() {
        self.wordWorker.resetIndex()
        self.providePlayers()
        self.proceedGame()
    }
}
