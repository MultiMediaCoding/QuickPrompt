//
//  NewPromptView.swift
//  QuickPrompt
//
//  Created by Lovis Steinmayer on 06.12.24.
//

import SwiftUI

struct NewPromptView: View {
    
    @Binding var presented: Bool
    @State private var titleInput = ""
    @State private var textInput = ""
    @State private var selectedCategory: Prompt.Category = .Education
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
            
            VStack(spacing: 10) {
                TextField("Enter title", text: $titleInput)
                    .font(.headline)
                    .foregroundStyle(Color.accentColor)
                
                Divider()
                
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $textInput)
                        .scrollContentBackground(.hidden)
                        .background(.clear)
                        .frame(height: 50)
                        .padding(.leading, -5)
                    
                    if textInput.isEmpty {
                        Text("Enter your prompt")
                            .foregroundColor(Color(.tertiaryLabelColor))
                    }
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                    
                    Picker("Kategorie", selection: $selectedCategory) {
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
            
            Spacer()
            
            HStack(spacing: 10) {
                Button("Fertig") {
                    if !textInput.isEmpty && !textInput.isEmpty {
                        viewModel.save(Prompt(title: titleInput, text: textInput, category: selectedCategory, createdDate: Date()))
                        presented = false
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(textInput.isEmpty && textInput.isEmpty ? .gray : .accentColor)
                
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
