//
//  EmojiMemorizeGameHolder.swift
//  MemorizeGame
//
//  Created by lwk on 2023/9/20.
//

import SwiftUI

class EmojiMemorizeGame: ObservableObject{
    
    private static let emojis:[String] = ["🤪","🧐","🤓","🥸","🫥","😈","🤡","🎃","😠","😢","💀","😆","😠"]
    private static let vehicles:[String] = ["🚗","🚚","🚄","🚁","✈️","🛸","🚢","⛵️","🚴","🛹"]
    private static let animals:[String] = ["🐱","🐯","🐭","🐮","🐲","🐍","🐎","🐑","🐒","🐔","🐶","🐷"]
    private var state:Array<String> = []
    
    
    private static func creatGameCore(_ numOfCards:Int)->GameCore<String>{
        return GameCore(numOfCards: numOfCards){ (index:Int)->String in
            if emojis.indices.contains(index){
                return emojis[index]
            }else{
                return "❓"
            }
        }
    }
    
    private func pickTheme(takeName nameOfTheme:String)-> Array<String>{
        switch nameOfTheme{
        case "vehicles":
            return EmojiMemorizeGame.vehicles
        case "animals":
            return EmojiMemorizeGame.animals
        case "emojis":
            return EmojiMemorizeGame.emojis
        default: return EmojiMemorizeGame.emojis
        }
    }
    
    @Published private var gameCore:GameCore<String> = creatGameCore(14)
    
    var cards: Array<GameCore<String>.Card>{
        return gameCore.cards
    }
    
    //MARK: - Behavior
    
    func shuffle(){
        gameCore.shuffle()
    }
    
    func changeTheme(to themeName:String){
        state = pickTheme(takeName: themeName)
        gameCore.reset(numOfCards: 14){ (index:Int)->String in
            if state.indices.contains(index){
                return state[index]
            }else{
                return "❓"
            }
        }
    }
    
    func istap(index:Int){
        gameCore.tap(index)
    }

}
