//
//  User.swift
//  BabbelGame
//
//  Created by Abbas Sabeti on 26/02/2022.
//

import Foundation
import UIKit

class Player : ObservableObject {
    @Published var name: String
    
    @Published var correctAnswers: Int
    
    @Published var incorrectAnswers: Int
    
    init(name: String,correctAnswers: Int = 0,incorrectAnswers: Int = 0){
        self.name = name
        self.correctAnswers = correctAnswers
        self.incorrectAnswers = incorrectAnswers
    }
    
    func reset(){
        self.correctAnswers = 0
        self.incorrectAnswers = 0
    }
    
    func incrementCorrectCount(){
        self.correctAnswers += 1
    }
    
    func incrementIncorrectCount(){
        self.incorrectAnswers += 1
    }
    
    func getNetScore() -> Int {
        return correctAnswers - incorrectAnswers
    }
}
