//
//  LiberaryGridItem.swift
//  QuickPrompt
//
//  Created by Lovis Steinmayer on 06.12.24.
//

import SwiftUI

struct LibraryGridItem: View {
    
    let prompt: Prompt
    
    var body: some View {
        Rectangle()
            .fill(.quinary)
            .frame(height: 150)
            .overlay(
                VStack(alignment: .leading, spacing: 5) {
                    
                    Image(systemName: promptSymbols[prompt.category.rawValue] ?? "text.alignleft")
                        .font(.title2)
                        .foregroundStyle(Color.accentColor)
                        .padding(.bottom, 10)
                    
                    Text(prompt.title)
                        .foregroundColor(.primary)
                        .font(.headline)
                    
                    Text(prompt.text)
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                }
                .padding()
            )
            .cornerRadius(10)
    }
}
