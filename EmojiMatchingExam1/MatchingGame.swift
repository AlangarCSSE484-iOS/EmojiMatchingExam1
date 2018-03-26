//
//  MatchingGame.swift
//  EmojiMatchingExam1
//
//  Created by CSSE Department on 3/25/18.
//  Copyright © 2018 Rose-Hulman. All rights reserved.
//

import UIKit
import Foundation

extension Array {
    mutating func shuffle() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            self.swapAt(i, j)
        }
    }
}

class MatchingGame: CustomStringConvertible{
    
    let allCardBacks = Array("🎆🎇🌈🌅🌇🌉🌃🌄⛺⛲🚢🌌🌋🗽")
    let allEmojiCharacters = Array("🚁🐴🐇🐢🐱🐌🐒🐞🐫🐠🐬🐩🐶🐰🐼⛄🌸⛅🐸🐳❄❤🐝🌺🌼🌽🍌🍎🍡🏡🌻🍉🍒🍦👠🐧👛🐛🐘🐨😃🐻🐹🐲🐊🐙")
    
    var description: String {
        return getGameString()
    }
    
    var firstClickIndex: Int?
    var secondClickIndex: Int?
    var gameState: gameState
    var cardStates: [cardState]
    var cards : [Character]
    var cardBack : Character
    
    
    enum cardState: String{
        case hidden = "Hidden"
        case shown = "Shown"
        case removed = "Removed"
    }
    enum gameState {
        case waitingFirst
        case waitingSecond
        case complete
        
        func simpleDescription() -> String {
            switch self {
                
            case .waitingFirst:
                return "Waiting for first selection"
            case .waitingSecond:
                return "Waiting for second selection: first click = "
            case .complete:
                return "turn complete: first click = , second click = "
            }
        }
    }
    
    
    init(numPairs: Int){
        self.gameState = .waitingFirst
        self.cardStates = [cardState](repeating: .hidden, count: numPairs*2)
        self.cards = [Character]()
        
        // Randomly select emojiSymbols
        var emojiSymbolsUsed = [Character]()
        while emojiSymbolsUsed.count < numPairs {
            let index = Int(arc4random_uniform(UInt32(allEmojiCharacters.count)))
            let symbol = allEmojiCharacters[index]
            if !emojiSymbolsUsed.contains(symbol) {
                emojiSymbolsUsed.append(symbol)
            }
        }
        emojiSymbolsUsed
        self.cards = emojiSymbolsUsed + emojiSymbolsUsed
        self.cards.shuffle()
        
        // Randomly select a card back for this round
        self.cardBack = allCardBacks[Int(arc4random_uniform(UInt32(allCardBacks.count)))]
        
        
    }
    
    
    
    func pressedCard(atIndex index: Int){
        if index >= cards.count {
            print("index out of bounds - check which card you pressed")
            return
        }
        if (!(cardStates[index] == .hidden)){
            print("you pressed a card that was already shown!")
            return
        }
        
        cardStates[index] = .shown
        if (firstClickIndex == nil) {
            self.gameState = .waitingSecond
            firstClickIndex = index
        }
        else if (secondClickIndex == nil) {
            self.gameState = .complete
            secondClickIndex = index
        }
        
        
    }
    
    func startNewTurn() {
        //remove
        if (cards[firstClickIndex!] == cards[secondClickIndex!] && firstClickIndex != nil){
            cardStates[firstClickIndex!] = .removed
            cardStates[secondClickIndex!] = .removed
        } else {
            cardStates[firstClickIndex!] = .hidden
            cardStates[secondClickIndex!] = .hidden
        }
        
        //reset
        firstClickIndex = nil
        secondClickIndex = nil
        self.gameState = .waitingFirst
    }
    
    func getGameString () -> String{
        //found on stack overflow
        return String((String(cards)).enumerated().map{$0 > 0 && $0 % 5 == 0 ? ["\n", $1] : [$1]}.joined())
        
    }
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
}
