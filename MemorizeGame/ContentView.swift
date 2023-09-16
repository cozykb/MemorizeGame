//
//  ContentView.swift
//  MemorizeGame
//
//  Created by lwk on 2023/9/15.
//

import SwiftUI

struct ContentView: View {
    var emojis:[String] = ["🤪","🧐","🤓","🥸","🫥","😈","🤡","🎃"]
    @State var cont = 1
    var body: some View {
        VStack{
            ScrollView{
                cards
            }
            Spacer()
            cardChanger
        }
        .padding()

    }
    
    func changeCard(by changecard: Int, symbol: String)-> some View{
        Button(action:{
            cont += changecard
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cont + changecard < 0 || cont + changecard  >= emojis.count)
    }
    
    var cards: some View{
        LazyVGrid(columns : [GridItem(.adaptive(minimum: 165))]){
            ForEach(0..<cont, id:\.self){
                index in
                CardView(content: emojis[index])
                    .aspectRatio(2/2, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
        .font(.largeTitle)
    }
    
    
    var cardChanger: some View{
        HStack{
            changeCard(by: -1, symbol:"rectangle.fill.badge.minus")
            Spacer()
            changeCard(by: +1, symbol:"rectangle.fill.badge.plus")
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    
    
}


struct CardView: View{
    let content: String
    @State var isFront = true

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
