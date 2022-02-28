//
//  SpyInitialGameInterctorDelegate.swift
//  BabbelGame
//
//  Created by Abbas Sabeti on 27/02/2022.
//

import Foundation
import UIKit

final class SpyInitialGameInteractorDelegate: InitialGameInteractorDelegate {
    func declareWinner(user: Player) {
        gameIsDone()
    }

    var gameIsDone : () -> Void

    init(gameIsDone: @escaping () -> Void) {
        self.gameIsDone = gameIsDone
    }

}
