//
//  SidebarListElement.swift
//  QuickPrompt
//
//  Created by Lovis Steinmayer on 06.12.24.
//

import SwiftUI

struct SidebarListElement: View {
    let prompt: Prompt
    
    let promptSymbols: [String: String] = [
        "Education": "graduationcap",
        "Developers": "hammer",
        "Fun": "smiley",
        "PreciseAwnsers": "questionmark.circle",
        "Lists": "list.bullet"
    ]
    
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: promptSymbols[prompt.category.rawValue] ?? "text.alignleft")
                .font(.title3)
                .foregroundStyle(Color.accentColor)
            
            VStack(alignment: .leading) {
                Text(prompt.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(prompt.text)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}
