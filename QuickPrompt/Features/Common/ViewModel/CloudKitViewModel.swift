//
//  QuickPromptViewModel.swift
//  AirCaptain
//
//  Created by Lovis Steinmayer on 06.12.24.
//

import SwiftUI

class CloudKitViewModel: ObservableObject {
    
    @Published var prompts = [Prompt]()
    @Published var searchResults: [Prompt] = []
    
    init() {
        Task {
            await getPrompts()
        }
    }
    
    func getPrompts() async {
        if let prompts = await CloudKitService.shared.getPrompts() {
            DispatchQueue.main.async {
                withAnimation(.spring) {
                    self.prompts = prompts
                }
            }
        }
    }
    
    func searchPrompts(searchText: String) async {
        if let prompts = await CloudKitService.shared.searchPrompts(searchText: searchText) {
            withAnimation(.spring) {
                self.searchResults = prompts
            }
        }
    }
    
    func save(_ prompt: Prompt) {
        CloudKitService.shared.save(prompt)
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "de_DE")
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}


