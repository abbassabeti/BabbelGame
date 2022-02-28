//
//  PlayerView.swift
//  BabbelGame
//
//  Created by Abbas Sabeti on 26/02/2022.
//

import SwiftUI

struct PlayerView: View {

    @ObservedObject var user: Player
    let angle: Double
    let action : () -> Void

    var body: some View {
        VStack {
            HStack {
                Text(displayNumber(user.incorrectAnswers))
                    .foregroundColor(Color.red)
                    .font(.system(size: 19))
                Text(displayNumber(user.correctAnswers))
                    .foregroundColor(Color.green)
                    .font(.system(size: 19))
            }
            Button(user.name, action: action)
                .font(.system(size: 19))
                .padding([.leading, .trailing], 8)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(3)
        }
        .rotationEffect(.degrees(angle))
    }
}
