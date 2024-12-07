//
//  MenuBarView.swift
//  QuickPrompt
//
//  Created by Hans Poreda on 06.12.24.
//

import SwiftUI

struct MenuBarView: View {
    @EnvironmentObject var viewModel: PromptsViewModel
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                VStack(alignment: .leading) {
                    GroupedBoxTitle(title: "Your Prompts")
                    
                    GroupedBox {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.secondary)
                            
                            TextField("Search", text: $viewModel.searchText)
                                .textFieldStyle(.plain)
                            
                            Spacer()
                            
                            if viewModel.searchText != "" {
                                Button {
                                    viewModel.searchText = ""
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundStyle(.secondary)
                                }.buttonStyle(.plain)
                                
                            }
                        }
                    }
                    
                    
                    
                    PromptsListView()
                }
            }
            .padding(15)
        }
    }
}
