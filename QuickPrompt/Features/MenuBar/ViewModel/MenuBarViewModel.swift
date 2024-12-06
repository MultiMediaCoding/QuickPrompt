//
//  MenuBarViewModel.swift
//  QuickPrompt
//
//  Created by Hans Poreda on 06.12.24.
//

import SwiftUI

class MenuBarViewModel: ObservableObject {
    @Published var copiedPrompt: Prompt?
    
    func copyPrompt(_ prompt: Prompt) {
        copiedPrompt = prompt
        ClipboardManager.shared.copyPrompt(prompt: prompt)
    }
}
