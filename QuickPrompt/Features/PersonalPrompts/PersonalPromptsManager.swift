//
//  PersonalPromptsManager.swift
//  QuickPrompt
//
//  Created by Hans Poreda on 07.12.24.
//

import Foundation
import CloudKit

class PersonalPromptsManager {
    static let shared = PersonalPromptsManager()
    
    var savedPromptIds: [String] {
        get {
            UserDefaults.standard.object(forKey:"PersonalPromptIds") as? [String] ?? [String]()
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "PersonalPromptIds")
        }
    }
    
    func addId(_ id: String) {
        savedPromptIds.append(id)
    }
    
    func removeId(_ id: String) {
        savedPromptIds.removeAll { $0 == id }
    }
}
