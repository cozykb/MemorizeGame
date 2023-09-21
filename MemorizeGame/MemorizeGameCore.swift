//
//  MemorizeGameCore.swift
//  MemorizeGame
//
//  Created by lwk on 2023/9/20.
//

import Foundation


struct GameCore<CardContent>{
    private(set) var cards: Array<Card>
    
    struct Card{
        let content: CardContent
        var isFaceup: Bool = false
        var isMatch: Bool = false
    }
    
    init(numOfCards:Int, contentOfcards:(Int)->CardContent) {
        cards = []
        for index in 0..<max(2,numOfCards){
            for _ in 0..<2{
                cards.append(Card(content: contentOfcards(index)))
            }
        }
    }
    
    //MARK: - Behavior
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    mutating func reset(numOfCards:Int, contentOfcards:(Int)->CardContent){
        cards = []
        for index in 0..<max(2,numOfCards){
            for _ in 0..<2{
                cards.append(Card(content: contentOfcards(index)))
            }
        }
    }
    
    mutating func tap(_ index:Int){
        cards[index].isFaceup.toggle()
    }
    
}
