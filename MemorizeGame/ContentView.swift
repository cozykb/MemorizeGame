//
//  ContentView.swift
//  MemorizeGame
//
//  Created by lwk on 2023/9/15.
//

import SwiftUI

struct ContentView: View {
    let emojis:[String] = ["🤪","🧐","🤓","🥸","🫥","😈","🤡","🎃","😠","😢","💀","😆","😠"]
    let vehicles:[String] = ["🚗","🚚","🚄","🚁","✈️","🛸","🚢","⛵️","🚴","🛹"]
    let animals:[String] = ["🐱","🐯","🐭","🐮","🐲","🐍","🐎","🐑","🐒","🐔","🐶","🐷"]
    @State var displays:[String] = []
    @State var isInit = true
    @State var theme = "emojis"
    @State var cont = 0
    var body: some View {
        VStack{
            Text("Memorize")
                .font(.largeTitle)
                .foregroundColor(.blue)
            ScrollView{
                cards
            }
            .padding()
            buttonViews
        }
        .padding()
    }
    
    var buttonViews:some View{
        VStack(spacing: 0.0){
            themebutton
            initButton
            cardChanger
        }
    }
    
    func initDisplays(with theme:Array<String>){
        var rdInt: Int
        for _ in 0..<2{
            rdInt = Int.random(in: 0..<theme.count)
            for _ in 0..<2{
                displays.append(theme[rdInt])
            }
        }
        displays.shuffle()
    }
    
    
    func pickTheme(takeName nameOfTheme:String)-> Array<String>{
        switch nameOfTheme{
        case "vehicles":
            return vehicles
        case "animals":
            return animals
        case "emojis":
            return emojis
        default: return emojis
        }
    }
    
    func changeTheme(takeName nameOfTheme:String, symbol: String)-> some View{
        Button(action:{
            theme = nameOfTheme
            if isInit{
                cont = 4
                initDisplays(with: pickTheme(takeName: nameOfTheme))
                isInit = false
            }
        }, label: {
            VStack{
                Image(systemName: symbol)
                Text(nameOfTheme)
                    .font(.footnote)
            }
            
        })
    }
    
    func addDisplays(from addTheme: Array<String>, by changecard: Int){
        let rdInt = Int.random(in: 0..<addTheme.count)
        for _ in 0..<2{
            displays.append(addTheme[rdInt])
        }
        displays.shuffle()
        cont += changecard
    }
    
    func removeDisplay(from themeArray: Array<String>, by changecard: Int){
        var cardString:String?
        for cardDisplay in displays{
            if themeArray.contains(cardDisplay){
                cardString = cardDisplay
                break
            }
        }
        if let cardString = cardString{
            for _ in 0..<2{
                if let index = displays.firstIndex(of: cardString){
                    displays.remove(at: index)
                }
            }
            cont += changecard
        }
    }
    
    func changeCard(by changecard: Int, symbol: String, with inlist: Array<String>)-> some View{
        Button(action:{
            if changecard > 0{
                addDisplays(from: pickTheme(takeName: theme), by: changecard)
            }else{
                removeDisplay(from: pickTheme(takeName: theme), by: changecard)
            }
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cont + changecard < 4 || cont + changecard  >= 38)
    }
    
    var cards: some View{
        LazyVGrid(columns : [GridItem(.adaptive(minimum: 45))]){
            ForEach(0..<cont, id:\.self){
                index in
                CardView(content: displays[index])
                    .aspectRatio(2/2, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
        .font(.largeTitle)
    }
    
    
    
    var cardChanger: some View{
        HStack{
            changeCard(by: -2, symbol:"rectangle.fill.badge.minus", with: pickTheme(takeName: theme))
            Spacer()
            changeCard(by: +2, symbol:"rectangle.fill.badge.plus", with: pickTheme(takeName: theme))
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var initButton: some View{
        Button(action:{
            displays.removeAll()
            cont = 0
            isInit = true
        },label: {
            Text("restart")
                .foregroundColor(.blue)
        }
        )
    }
    
    var themebutton: some View{
        HStack{
            changeTheme(takeName: "emojis", symbol: "face.smiling")
            changeTheme(takeName: "animals", symbol: "pawprint")
            changeTheme(takeName: "vehicles", symbol: "car")
        }
        .foregroundColor(.blue)
        .padding()
        .imageScale(.large)
        .font(.largeTitle)
    }
    
}

struct CardView: View{
    let content: String
    @State var isFront = false

    let basecard = RoundedRectangle(cornerRadius: 12)
    var body: some View{
        ZStack{
            Group{
                basecard.foregroundColor(.white)
                basecard.strokeBorder(lineWidth: 2)
                Text(content)
            }
            .opacity(isFront ? 1 : 0)
            basecard.opacity(isFront ? 0 : 1)
        }
        .onTapGesture{
            isFront.toggle()
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
