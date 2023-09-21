//
//  MemorizeGameApp.swift
//  MemorizeGame
//
//  Created by lwk on 2023/9/15.
//

import SwiftUI

@main
struct MemorizeGameApp: App {
    @StateObject var game = EmojiMemorizeGame()
    var body: some Scene {
        WindowGroup {
            MemorizeGameView(emojiGame: game)
        }
    }
}
