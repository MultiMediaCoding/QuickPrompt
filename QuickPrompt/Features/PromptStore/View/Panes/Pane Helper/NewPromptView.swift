//
//  NewPromptView.swift
//  QuickPrompt
//
//  Created by Lovis Steinmayer on 06.12.24.
//

import SwiftUI

struct NewPromptView: View {
    
    @Binding var presented: Bool
    @State private var prompt = Prompt(id: UUID().uuidString, title: "", defaultText: "", placeholderText: "", category: .All, inputParameters: [], createdDate: .now)
    @EnvironmentObject var viewModel: CloudKitViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Neuer Prompt")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text("Füge einen neuen Prompt hinzu")
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 30)
            .padding(.bottom, 10)
            
            InputParametersListView(inputParameters: $prompt.inputParameters)
            
            VStack(spacing: 10) {
                TextField("Enter title", text: $prompt.title)
                    .font(.headline)
                    .foregroundStyle(Color.accentColor)
                
                Divider()
                
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $prompt.placeholderText)
                        .scrollContentBackground(.hidden)
                        .background(.clear)
                        .frame(height: 50)
                        .padding(.leading, -5)
                    
                    if prompt.defaultText.isEmpty {
                        Text("Enter your prompt")
                            .foregroundColor(Color(.tertiaryLabelColor))
                    }
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                    
                    Picker("Kategorie", selection: $prompt.category) {
                        ForEach(Prompt.Category.allCases, id: \.self) { category in
                            Text(category.rawValue)
                                .tag(category)
                        }
                    }
                    .pickerStyle(.menu)
                }
                .padding(.top, 10)
            }
            .textFieldStyle(.plain)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .padding(.horizontal)
            .font(.body)
            
            HighlightedText(inputText: prompt.placeholderText, keywords: prompt.inputParameters.compactMap({$0.parameterName}))
            
            Spacer()
            
            HStack(spacing: 10) {
                Button("Fertig") {
                    if prompt.title != "" && prompt.placeholderText != "" {
                        viewModel.save(prompt)
                        presented = false
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(prompt.title == "" && prompt.defaultText == "" ? .gray : .accentColor)
                
                Button("Abbrechen") {
                    presented = false
                }
                .buttonStyle(.bordered)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 20)
            .padding(.top, 20)
        }
    }
}

#Preview {
    NewPromptView(presented: .constant(true))
}
