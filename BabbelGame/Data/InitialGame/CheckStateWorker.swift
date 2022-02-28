//
//  CheckStateWorker.swift
//  BabbelGame
//
//  Created by Abbas Sabeti on 26/02/2022.
//

import Foundation

protocol CheckStateWorkerProtocol: AnyObject {
    func checkIfGameIsDone(players: [Player]) -> Player?
}

final class CheckStateWorker: CheckStateWorkerProtocol {
    func checkIfGameIsDone(players: [Player]) -> Player? {
        guard let pioneer = getTwoBestPlayers(players: players) else {return nil}
        guard pioneer.getNetScore() >= GameConstants.minimumWinnerScore else {return nil}
        return pioneer
    }

    private func getTwoBestPlayers(players: [Player]) -> Player? {
        let sortedItems = players.sorted(by: {$0.getNetScore() > $1.getNetScore()})
        return sortedItems.first
    }
}
