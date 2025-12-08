//
//  Game.swift
//  Apple Pie
//
//  Created by fall2025 on 12/7/25.
//

import Foundation

struct Game {
    var word: String
    var iscorrectMovesRemaining: Int
    var guessedLetters: [Character]
    
    var formattedWord: String {
        var guessWord = ""
        for letter in word {
            if guessedLetters.contains(letter) {
                guessWord += "\(letter)"
            }else{
                guessWord += "_"
            }
        }
        return guessWord
    }
    
    
    mutating func playerGuessed(letter: Character){
        guessedLetters.append(letter)
        if !word.contains(letter){
            iscorrectMovesRemaining -= 1
        }
    }
}


