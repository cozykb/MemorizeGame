//
//  ContentView.swift
//  MemorizeGame
//
//  Created by lwk on 2023/9/15.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView()
            CardView()
            CardView(isFront: false)
            CardView()
            CardView()
        }
        .padding()
        .foregroundColor(.orange)
    }
}


struct CardView: View{
    var isFront: Bool = true
    
    var body: some View{
        ZStack{
            if isFront{
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 2)
                Text("🤪")
            }
            else{
                RoundedRectangle(cornerRadius: 12)
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
