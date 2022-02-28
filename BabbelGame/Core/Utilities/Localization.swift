//
//  LocalizedOperator.swift
//  BabbelGame
//
//  Created by Abbas Sabeti on 26/02/2022.
//

import SwiftUI

// This operator is for converting keys to localized strings
postfix operator ~
postfix func ~ (string: String) -> String {
    return NSLocalizedString(string, comment: "")
}

func displayNumber(_ value: Int) -> String {
    let numFormatter = NumberFormatter()
    numFormatter.locale = Locale.current
    return numFormatter.string(from: value as NSNumber) ?? ""
}
