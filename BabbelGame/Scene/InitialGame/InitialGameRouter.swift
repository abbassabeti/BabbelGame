//
//  InitialGameRouter.swift
//  BabbelGame
//
//  Created by Abbas Sabeti on 26/02/2022.
//

import SwiftUI
import Foundation

protocol InitialGameRouterProtocol : AnyObject {
    func presentInitialGame()
}

class InitialGameRouter : InitialGameRouterProtocol {
    func presentInitialGame(){
        let wordsWorker = WordsWorker()
        let stateWorker = CheckStateWorker()
        let interactor = InitialGameInteractor(wordWorker: wordsWorker, stateWorker: stateWorker)
        let presenter = InitialGamePresenter(interactor: interactor)
        let view = InitialGameView(presenter: presenter)
        SceneDelegate.presentView(view: AnyView(view))
    }
}

