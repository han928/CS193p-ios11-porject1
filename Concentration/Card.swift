//
//  Card.swift
//  Concentration
//
//  Created by Han Lai on 11/21/17.
//  Copyright © 2017 Han Lai. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
//        print("unique identifer is \(identifierFactory)")
        identifierFactory += 1
        return identifierFactory
    }
    
    static func resetIdentifierFactory() {
        identifierFactory = 0
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
