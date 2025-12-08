//
//  ViewController.swift
//  Apple Pie
//
//  Created by fall2025 on 12/7/25.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var correctWordLabel: UILabel!
    
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    var listOfWords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program"]

    let iscorrectMovesAllowed = 7
    var totalWin = 0 {
        didSet {newRound()}
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    var score = 0

    
    var currentGame: Game!
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        
        guard let letterString = sender.title(for: .normal) else { return }
        let letter = Character(letterString.lowercased())
        
        let wasCorrect = currentGame.word.contains(letter)
        currentGame.playerGuessed(letter: letter)
        
        if wasCorrect {
            score += 10
        }
        
        updateGameState()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newRound()
    }
    


    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(
                word: newWord,
                iscorrectMovesRemaining: iscorrectMovesAllowed, guessedLetters: []
            )
            enableLetterButtons(true)
            updateUI()
            
        } else {
            enableLetterButtons(false)
        }
        
    }
   
    
    func updateUI() {
        
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        
        let spaceWord = letters.joined(separator: " ")
        correctWordLabel.text = spaceWord
        
        scoreLabel.text = "Win: \(totalWin), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.iscorrectMovesRemaining)")
    }
    
    
    func updateGameState() {
        if currentGame.iscorrectMovesRemaining == 0 {
            totalLosses += 1
        }else if currentGame.word == currentGame.formattedWord {
            score += 100
            totalWin += 1
        }else{
            updateUI()
        }
    }
    
    func enableLetterButtons(_ enable: Bool){
        for button in letterButtons {
            button.isEnabled = enable
        }
    }


}

