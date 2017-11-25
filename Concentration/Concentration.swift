//
//  Concentration.swift
//  Concentration
//
//  Created by Han Lai on 11/21/17.
//  Copyright © 2017 Han Lai. All rights reserved.
//

import Foundation

class Concentration
{
    private(set) var cards = [Card]()
    
    var flipCount = 0
    
    //TODO: Concentration should hold score and update score.
    private(set) var score = 0
    /*
     Scenarios for updating score:
     First Card Flipped:
         1. +0 if it has not been flipped
         2. -1 if it has been flipped
     
     Second Card Flipped:
        1. a match: +2
        2. no match: go back to scenario as first card flipped
    */
    
    
    private var indexOfOneAndOnlyFaceUpCard: Int?
    {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        
        // update flipCount
        flipCount += 1
        
        //
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    // scored
                    score += 2
                }
                else {
                    
                    let isFlipedMultiplier =  Int(truncating: NSNumber(value:cards[index].isFliped)) + Int(truncating: NSNumber(value:cards[matchIndex].isFliped))
                    // no match and cards been flipped
                    score -= (1 * isFlipedMultiplier)
                }
                
                cards[index].isFliped = true
                cards[matchIndex].isFliped = true

                cards[index].isFaceUp = true
                
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
        print("Score is \(score)")
    }
    
    
    init (numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0 , "Concentration.init(at: \(numberOfPairsOfCards)): you must have at least one pair of cards")

        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        // initialize flipCount
        flipCount = 0
        
        // Shuffle the cards
        var tempCard = [Card]()
        
        for _ in 0..<cards.count {
            let randNum = Int(arc4random_uniform(UInt32(cards.count)))
            tempCard.append(cards.remove(at: randNum))
        }
        cards = tempCard
        
    }
    
}
