//
//  Concentration.swift
//  Concentration
//
//  Created by Seab Jackson on 1/10/18.
//  Copyright © 2018 Seab Jackson. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    
    func choseCard(at index: Int) {
        if cards[index].isFaceUp {
            cards[index].isFaceUp = false
        } else {
            cards[index].isFaceUp = true
        }
    }

    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        // TODO: Shuffle the cards
    }
}







