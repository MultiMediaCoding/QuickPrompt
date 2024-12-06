//
//  MenuBarViewModel.swift
//  QuickPrompt
//
//  Created by Hans Poreda on 06.12.24.
//

import SwiftUI

class MenuBarViewModel: ObservableObject {
    @Published var searchText: String = ""

    var filteredPrompts: [Prompt] {
        gptPromptsLibrary.compactMap({$0.title.lowercased().contains(searchText.lowercased()) || $0.text.lowercased().contains(searchText.lowercased()) ? $0 : nil })
    }
    
    var prompts: [Prompt] { searchText == "" ? gptPromptsLibrary : filteredPrompts }
    
    @Published var copiedPrompt: Prompt?
    
    func copyPrompt(_ prompt: Prompt) {
        copiedPrompt = prompt
        ClipboardManager.shared.copyPrompt(prompt: prompt)
    }
}
