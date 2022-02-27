//
//  Parser.swift
//  BabbelGame
//
//  Created by Abbas Sabeti on 26/02/2022.
//

import Foundation
import Combine

final class GameDataProvider {

    class func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, Error> {
    let decoder = JSONDecoder()

    return Just(data)
    .decode(type: T.self, decoder: decoder)
    .mapError { error in
      return DecodeError(description: error.localizedDescription)
    }
    .eraseToAnyPublisher()
}

    class func getData(fileName: String = GameConstants.gameDataFileName) -> Data? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch _ {

            }
    }
    return nil
}
}
