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
        VStack{
            HStack{
                Text(displayNumber(user.incorrectAnswers))
                    .foregroundColor(Color.red)
                Text(displayNumber(user.correctAnswers))
                    .foregroundColor(Color.green)
            }
            Button(user.name, action: action)
                .padding([.leading,.trailing], 8)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(3)
        }
        .rotationEffect(.degrees(angle))
    }
}
