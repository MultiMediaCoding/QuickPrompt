//
//  QuickPromptApp.swift
//  QuickPrompt
//
//  Created by Hans Poreda on 06.12.24.
//

import SwiftUI

@main
struct QuickPromptApp: App {
    @StateObject private var promptsViewModel: PromptsViewModel = .init()
    @StateObject private var cloudKitViewModel: CloudKitViewModel = .init()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(promptsViewModel)
                .environmentObject(cloudKitViewModel)
        }
        
        MenuBarExtra("QuickPrompt", systemImage: "note.text") {
            MenuBarView()
                .environmentObject(promptsViewModel)
                .environmentObject(cloudKitViewModel)
        }
        .menuBarExtraStyle(.window)
    }
}
