//
//  MockError.swift
//  BabbelGame
//
//  Created by Abbas Sabeti on 26/02/2022.
//

import Foundation

struct MockError: Error {
    static let sampleError = MockError(description: "sample_error"~)
    var description: String
}
