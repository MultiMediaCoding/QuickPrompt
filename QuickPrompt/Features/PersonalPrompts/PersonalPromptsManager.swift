//
//  PersonalPromptsManager.swift
//  QuickPrompt
//
//  Created by Hans Poreda on 07.12.24.
//

import Foundation
import CloudKit

import Foundation

class PersonalPromptsManager {
    static let shared = PersonalPromptsManager()
    
    private let promptsKey = "PersonalPrompts"
    
    var savedPrompts: [Prompt] {
        get {
            if let data = UserDefaults.standard.data(forKey: promptsKey),
               let prompts = try? JSONDecoder().decode([Prompt].self, from: data) {
                return prompts
            }
            return []
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: promptsKey)
            }
        }
    }
    
    func addPrompt(_ prompt: Prompt) {
        var prompts = savedPrompts
        prompts.append(prompt)
        savedPrompts = prompts
    }
    
    func removePrompt(_ prompt: Prompt) {
        var prompts = savedPrompts
        prompts.removeAll { $0.id == prompt.id }
        savedPrompts = prompts
    }
}
