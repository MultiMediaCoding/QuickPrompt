//
//  PromtListItem.swift
//  QuickPrompt
//
//  Created by Hans Poreda on 06.12.24.
//

import SwiftUI

struct PromptListItem: View {
    @EnvironmentObject var viewModel: PromptsViewModel
    let prompt: Prompt
    var body: some View {
        GroupedBox {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: prompt.icon)
                            .font(.subheadline)
                            .foregroundStyle(Color.accentColor)
                        
                        Text(prompt.title)
                            .font(.headline)
                            .fontWeight(.medium)
                        
                        Spacer()
                    }
                    
                    Text(prompt.text)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
                .padding(.trailing, 8)
                
                Button {
                    viewModel.copyPrompt(prompt)
                } label: {
                    GroupedBox {
                        Image(systemName: viewModel.copiedPrompt == prompt ? "rectangle.on.rectangle.fill" : "rectangle.on.rectangle")
                            .font(.subheadline)
                            .contentTransition(.symbolEffect(.replace))
                            .padding(-2)
                    }
                }
                .buttonStyle(.plain)
              
            }.frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    PromptListItem(prompt: gptPromptsLibrary[0])
}
