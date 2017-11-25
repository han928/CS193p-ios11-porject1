//
//  ViewController.swift
//  Concentration
//
//  Created by Han Lai on 11/20/17.
//  Copyright © 2017 Han Lai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
            return (cardButtons.count + 1) / 2
    }
    
    
    // TODO: get flipCount from Concnetration calss and also update text label
//    private(set) var flipCount = 0 {
//        didSet {
//            flipCountLabel.text = "Flips: \(flipCount)"
//        }
//    }

    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            
            // update flipCountLabel
            flipCountLabel.text = "Flips: \(game.flipCount)"

        } else {
            print("chosen card not in cardButtons")
        }
    }
    
    
    @IBAction func startNewGame() {
        print("touch the new game button")
        // we started concentration as a new game but card identifierFactory is not reset.
        Card.resetIdentifierFactory()

        // reset game to new game state
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        
        
        // controller to flip all the card over
        updateViewFromModel()
        
        // set flipCountLabel to 0
        flipCountLabel.text = "Flips: \(game.flipCount)"

    }
    
    
    private func updateViewFromModel(){
        // TODO: probably have to choose theme starting here when we first updated the view
        
        
        for index in cardButtons.indices {
            
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    
    private var emojiChoices = ["🎃", "👻", "😃", "🐸", "🦄", "🍔", "🌮", "🤪", "😎"]
    private var emoji =  [Int:String]()

    
    // emojiTheme is a dictionary where keys is the name of the theme and value is a list of available emojis in that theme
    private var emojiTheme = ["animal": ["🐶", "🐱", "🐭", "🦊", "🐷", "🐔", "🐴", "🦉" ,"🐍", "🐢"],
                              "sports": ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓", "🏸"],
                              "faces": ["😀", "😅", "😂", "🤣", "😊", "😇", "😍", "😘", "😎", "🤓"],
                              "food": ["🍎", "🍊", "🍓", "🍌", "🍉", "🍇", "🍒", "🍍", "🍅","🥑"],
                              "transportation": ["🚗", "🚕", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚲", "🛵"],
                              "flags": ["🏳️", "🏁", "🚩", "🇦🇽", "🇦🇬", "🇦🇿", "🇨🇼", "🇫🇰", "🇲🇵", "🇹🇼"]]
    
    
    // Generate a dictionary where key is the name of the theme and value is a dictionary of index vs. emoji
    private var emojiThemeIndices = [String:[Int:String]]()
    
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil,  emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
 
}

extension Int{
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))

        } else if self < 0 {
            return Int(arc4random_uniform(UInt32(abs(self))))

        } else {
            return 0
        }
    }
}
