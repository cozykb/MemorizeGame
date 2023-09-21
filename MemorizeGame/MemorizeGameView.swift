//
//  MemorizeGameView.swift
//  MemorizeGame
//
//  Created by lwk on 2023/9/15.
//

import SwiftUI

struct MemorizeGameView: View {
    
    @ObservedObject var emojiGame: EmojiMemorizeGame
    
    var body: some View {
        VStack{
            Text("Memorize")
                .font(.largeTitle)
                .foregroundColor(.black)
            ScrollView{
                cards
            }
            .padding()
            Button(action: emojiGame.shuffle, label: {
                Text("shuffle")
            })
                        buttonViews
        }
        .padding()
    }
    
    var buttonViews:some View{
        VStack(spacing: 0.0){
            themebutton
        }
    }
    
    var cards: some View{
        LazyVGrid(columns : [GridItem(.adaptive(minimum: 50))]){
            ForEach(emojiGame.cards.indices, id:\.self){
                index in
                CardView(card:emojiGame.cards[index])
                    .aspectRatio(2/2, contentMode: .fit)
                    .onTapGesture {
                        emojiGame.istap(index: index)
                    }
            }
        }
        .foregroundColor(.orange)
        .font(.largeTitle)
    }
    
    func changeTheme(takeName: String, symbol: String)->some View{
        return Button(action: {
            emojiGame.changeTheme(to: takeName)
        }, label: {
            Text(Image(systemName: symbol))
        })
    }
    
    
    var themebutton: some View{
        HStack{
            changeTheme(takeName: "emojis", symbol: "face.smiling")
            changeTheme(takeName: "animals", symbol: "pawprint")
            changeTheme(takeName: "vehicles", symbol: "car")
        }
        .foregroundColor(.blue)
        .padding()
//        .imageScale(.large)
//        .font(.largeTitle)
    }
    
    struct CardView: View{
        let card:GameCore<String>.Card
        
        let basecard = RoundedRectangle(cornerRadius: 12)
        var body: some View{
            ZStack{
                Group{
                    basecard.foregroundColor(.white)
                    basecard.strokeBorder(lineWidth: 2)
                    Text(card.content)
                }
                .opacity(card.isFaceup ? 1 : 0)
                basecard.opacity(card.isFaceup ? 0 : 1)
            }
        }
    }
    
    struct MemorizeGameView_Previews: PreviewProvider {
        static var previews: some View {
            MemorizeGameView(emojiGame: EmojiMemorizeGame())
        }
    }
}
