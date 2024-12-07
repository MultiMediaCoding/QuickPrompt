//
//  SidebarListElement.swift
//  QuickPrompt
//
//  Created by Lovis Steinmayer on 06.12.24.
//

import SwiftUI

struct SidebarListElement: View {
    let category: String
    
    let promptSymbols: [String: String] = [
        "Education": "graduationcap",
        "Developers": "hammer",
        "Fun": "smiley",
        "Precise Awnsers": "text.redaction",
        "Lists": "list.bullet"
    ]
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: promptSymbols[category] ?? "sparkles.rectangle.stack")
                .font(.title3)
                .foregroundStyle(Color.accentColor)
            
            VStack(alignment: .leading) {
                Text(category)
                    .foregroundStyle(.primary)
            }
        }
        .padding(.vertical, 5)
    }
}
