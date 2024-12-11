//
//  PromptsListView.swift
//  QuickPrompt
//
//  Created by Hans Poreda on 06.12.24.
//

import SwiftUI

struct PromptsListView: View {
    @EnvironmentObject var viewModel: PromptsViewModel
    var body: some View {
        if viewModel.prompts.isEmpty {
            Text("You have no saved prompts yet.")
                .foregroundStyle(.secondary)
                .padding(.top)
        }
        else {
            VStack(alignment: .leading){
                PlainButton {
                    if let selectedPrompt = viewModel.selectedPrompt {
                        viewModel.copyPrompt(selectedPrompt)
                    }
                }
                .keyboardShortcut(.defaultAction)
                
                ForEach(viewModel.prompts, id: \.self) { prompt in
                    PromptListItem(prompt: prompt)
                        .id(prompt.id)
                }
            }
            
            .onAppear {
                viewModel.selectedPrompt = nil
                viewModel.copiedPrompt = nil
                viewModel.searchText.removeAll()
            }
        }
    }
}

#Preview {
    PromptsListView()
}

