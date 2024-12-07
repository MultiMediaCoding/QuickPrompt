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
    
    var filteredPrompts: [Prompt] {
        savedPrompts.compactMap({$0.title.lowercased().contains(searchText.lowercased()) || $0.text.lowercased().contains(searchText.lowercased()) ? $0 : nil })
    }
    
    var prompts: [Prompt] { searchText == "" ? savedPrompts : filteredPrompts }
    
    init() {
        Task {
            await getSavedPropmpts()
        }
    }
    
    func savePrompt(_ prompt: Prompt) {
        savedPrompts.append(prompt)
       
        PersonalPromptsManager.shared.addId(prompt.id)
    }
    
    func deletePrompt(_ prompt: Prompt) {
        savedPrompts.removeAll(where: { $0.id == prompt.id })
        PersonalPromptsManager.shared.removeId(prompt.id)
    }
    
    func getSavedPropmpts() async {
        DispatchQueue.main.async {
            withAnimation(.spring) {
                self.isLoading.toggle()
            }
        }
        
        let promptIds = PersonalPromptsManager.shared.savedPromptIds
        let recordIds = promptIds.compactMap({CKRecord.ID(recordName: $0)})
        
        if let prompts = await CloudKitService.shared.getPromptsByIds(for: recordIds) {
            DispatchQueue.main.async {
                self.savedPrompts = prompts
            }
        }
        
        DispatchQueue.main.async {
            withAnimation(.spring) {
                self.isLoading.toggle()
            }
        }
    }
    
    func copyPrompt(_ prompt: Prompt) {
        copiedPrompt = prompt
        ClipboardManager.shared.copyPrompt(prompt: prompt)
    }
}
