//
//  MenuBarView.swift
//  QuickPrompt
//
//  Created by Hans Poreda on 06.12.24.
//

import SwiftUI

struct MenuBarView: View {
    @EnvironmentObject var viewModel: PromptsViewModel
    @State private var position = ScrollPosition(x:0, y: 0)
    @FocusState private var isFocused: Bool
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
                                .focused($isFocused)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        isFocused = true
                                    }
                                }
                                .onChange(of: viewModel.searchText) { _, _ in
                                    viewModel.selectedPrompt = viewModel.prompts.first
                                }
                            
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
        .scrollPosition($position)
        .onAppear {
            configureNSKeyEvents()
        }
    }
    
    func configureNSKeyEvents() {
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            if event.keyCode == 125 {
                // Arrow-Down
                viewModel.selectPrompt(addIndex: 1)
                
                position.scrollTo(id: viewModel.selectedPrompt?.id)
            }
            return event
        }
        
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            if event.keyCode == 126 {
                // Arrow-Down
                viewModel.selectPrompt(addIndex: -1)
                
                position.scrollTo(id: viewModel.selectedPrompt?.id)
            }
            return event
        }
    }
}

