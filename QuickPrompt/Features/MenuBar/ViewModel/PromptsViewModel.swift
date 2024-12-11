//
//  MenuBarViewModel.swift
//  QuickPrompt
//
//  Created by Hans Poreda on 06.12.24.
//

import SwiftUI
import CloudKit

class PromptsViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var savedPrompts: [Prompt] = []
    
    @Published var searchText: String = ""
    @Published var copiedPrompt: Prompt?
    
    @Published var selectedPrompt: Prompt?
    
    var filteredPrompts: [Prompt] {
        savedPrompts.compactMap({$0.title.lowercased().contains(searchText.lowercased()) || $0.text.lowercased().contains(searchText.lowercased()) ? $0 : nil })
    }
    
    var prompts: [Prompt] { searchText == "" ? savedPrompts : filteredPrompts }
    
    init() {
        savedPrompts = PersonalPromptsManager.shared.savedPrompts
    }
    
    func selectPrompt(addIndex: Int) {
        if
            let selectedPrompt = selectedPrompt,
            let index = prompts.firstIndex(of: selectedPrompt)
        {
            if index + addIndex <= prompts.count - 1 && index + addIndex >= 0 {
               let nextPrompt = prompts[index + addIndex]
                self.selectedPrompt = nextPrompt
            }
        }
    }
    
    func savePrompt(_ prompt: Prompt) {
        savedPrompts.append(prompt)
       
        PersonalPromptsManager.shared.addPrompt(prompt)
    }
    
    func deletePrompt(_ prompt: Prompt) {
        savedPrompts.removeAll(where: { $0.id == prompt.id })
        PersonalPromptsManager.shared.removePrompt(prompt)
    }
    
    func deleteAllPrompts() {
        for prompt in savedPrompts {
            PersonalPromptsManager.shared.removePrompt(prompt)
        }
        savedPrompts.removeAll()
    }
    
    func copyPrompt(_ prompt: Prompt) {
        copiedPrompt = prompt
        ClipboardManager.shared.copyPrompt(prompt: prompt)
    }
}
