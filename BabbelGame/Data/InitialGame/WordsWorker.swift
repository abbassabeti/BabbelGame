//
//  WordsWorker.swift
//  BabbelGame
//
//  Created by Abbas Sabeti on 26/02/2022.
//

import Foundation
import Combine

protocol WordsWorkerProtocol: AnyObject {
    var words: [GameWord] {get}
    var lastIndex: Int {get}
    func getNextWord() -> GameWord?
    func checkIfCorrect(meaning: String) -> Bool
    func resetIndex()
}

protocol WordsWorkerDelegate: AnyObject {
    func failed(error: Error)
}

final class WordsWorker: WordsWorkerProtocol {

    weak var delegate: WordsWorkerDelegate?

    var cancellables = Set<AnyCancellable>()

    init() {
        words = []
        lastIndex = -1
        getWords()
    }

    private func getWords() {
        guard let data = GameDataProvider.getData(fileName: "words") else {
            return
        }
        let cancellable: AnyPublisher<[Word], Error> = GameDataProvider.decode(data)

        cancellable.sink { completion in
            switch completion {
            case .failure(let error):
                self.delegate?.failed(error: error)
            default:
                break
            }
        } receiveValue: { words in
            let wrongMeaningList = words.map({$0.meaning})
            let wrongItemsCount = wrongMeaningList.count
            self.words = words.map({ word in
                let wrongMeaningSection = Array(
                    wrongMeaningList.shuffled().dropLast(wrongItemsCount - Int.random(in:
                                GameConstants.minimumWrongAnswers...GameConstants.maximumWrongAnswers)))
                return GameWord(original: word.original, meaning: word.meaning, fakeMeanings: wrongMeaningSection)
            }).shuffled()
        }.store(in: &cancellables)
    }

    var words: [GameWord]
    internal var lastIndex: Int
    internal var wrongMeaningIndex: Int = 0

    func getNextWord() -> GameWord? {
        guard words.count > 0 else {return nil}

        lastIndex += 1
        if lastIndex >= words.count {
            lastIndex = lastIndex % words.count
        }
        let index = lastIndex % words.count
        wrongMeaningIndex = 0
        return words[index]
    }

    func checkIfCorrect(meaning: String) -> Bool {
        let word = words[lastIndex]

        guard meaning == word.meaning else {
            return false
        }
        return true
    }

    func resetIndex() {
        self.lastIndex = -1
        self.words.shuffle()
    }
}
