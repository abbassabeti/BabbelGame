//
//  MockInitialGameInteractor.swift
//  BabbelGameTests
//
//  Created by Abbas Sabeti on 27/02/2022.
//

import Foundation
import Combine


struct SpyInitialGameInteractor : InitialGameInteractorProtocol {
    var delegate: InitialGameInteractorDelegate? = nil
    
    var players: CurrentValueSubject<[Player], Never> = .init([])
    
    var word: CurrentValueSubject<GameWord?, Never> = .init(nil)
    
    var playedForInfo: (Int,String) -> Void
    var proceededGame: () -> Void
    var resetedGame: () -> Void
    
    func playFor(userIndex: Int, meaning: String) {
        playedForInfo(userIndex,meaning)
    }
    
    func proceedGame() {
        proceededGame()
    }
    
    func resetGame() {
        resetedGame()
    }
    
    
}
