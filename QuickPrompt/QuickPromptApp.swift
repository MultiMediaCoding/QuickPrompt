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
    @StateObject var cloudKitViewModel: CloudKitViewModel = .init()
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        
        MenuBarExtra("QuickPrompt", systemImage: "note.text") {
            MenuBarView()
                .environmentObject(menuBarViewModel)
                .environmentObject(cloudKitViewModel)
        }
        .menuBarExtraStyle(.window)
    }
}
