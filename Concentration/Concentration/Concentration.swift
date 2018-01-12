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
    
    func choseCards(at index: Int) {
        
    }

    init(numberOfPairsOfCards: Int) {
        for identifier in 1...numberOfPairsOfCards {
            let card = Card(identifier: identifier)
            cards += [card, card]
        }
    }
}

