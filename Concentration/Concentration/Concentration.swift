//
//  Concentration.swift
//  Concentration
//
//  Created by Seab Jackson on 1/10/18.
//  Copyright © 2018 Seab Jackson. All rights reserved.
//

import Foundation

struct Concentration
{
    private(set) var cards = [Card]()
    
    // track number of flips
    private(set) var flipCount = 0
    private(set) var score = 0
    
    var seenCards: Set<Int> = []
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
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
    
    mutating func choseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    // update score by two points when a match is made
                    score += 2
                }
                cards[index].isFaceUp = true
                flipCount += 1
                
            } else {
                // either no card, or 2 cards are face up.
                flipCount += 1
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    mutating func reset() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            flipCount = 0
            score = 0
        }
        cards.shuffle()
    }

    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        // TODO: Shuffle the cards
        cards.shuffle()
    }
}

extension Array {
    
    public func random(_ n: Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }
    
    public mutating func shuffle() {
        for i in stride(from: count - 1, through: 1, by: -1) {
            let j = random(i + 1)
            if i != j {
                self.swapAt(i, j)
            }
        }
    }
    
}

























