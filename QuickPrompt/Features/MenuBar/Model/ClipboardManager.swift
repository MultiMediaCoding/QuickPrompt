//
//  ClipboardManager.swift
//  QuickPrompt
//
//  Created by Hans Poreda on 06.12.24.
//

import Foundation
import AppKit

class ClipboardManager {
    static let shared = ClipboardManager()
    
    func copyPrompt(prompt : Prompt) {
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([.string], owner: nil)
        pasteboard.setString(prompt.text, forType: .string)
    }
}
