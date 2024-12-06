//
//  QuickPromptApp.swift
//  QuickPrompt
//
//  Created by Hans Poreda on 06.12.24.
//

import SwiftUI

@main
struct QuickPromptApp: App {
    @StateObject var menuBarViewModel: MenuBarViewModel = .init()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
        MenuBarExtra("QuickPrompt", systemImage: "pencil.and.scribble") {
            MenuBarView()
                .environmentObject(menuBarViewModel)
        }
        .menuBarExtraStyle(.window)
    }
}
