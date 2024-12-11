//
//  NewPromptView.swift
//  QuickPrompt
//
//  Created by Lovis Steinmayer on 06.12.24.
//

import SwiftUI
import HighlightedTextEditor

struct NewPromptView: View {
    
    @Binding var presented: Bool
    @State private var prompt = Prompt(id: UUID().uuidString, title: "", defaultText: "", placeholderText: "", category: .All, inputParameters: [], createdDate: .now)
    @EnvironmentObject var viewModel: CloudKitViewModel
    
    @State private var selectedTab: Tab = .prompt
    
    enum Tab: String, CaseIterable {
        case prompt = "Prompt"
        case parameters = "Parameters"
    }
    
    var rules: [HighlightRule] {
        let highlightedWords = prompt.inputParameters.compactMap(\.parameterName)
        let pattern = highlightedWords.isEmpty
        ? ".*" // Standardmuster
        : highlightedWords.map { "\\b\($0.replacingOccurrences(of: " ", with: "\\s+"))\\b" }.joined(separator: "|")
        
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            fatalError("Ungültiges Regex-Muster: \(pattern)")
        }
        
        return [HighlightRule(pattern: regex, formattingRules: highlightedWords.isEmpty ? [] : [
            TextFormattingRule(fontTraits: [NSFontDescriptor.SymbolicTraits.bold]),
            TextFormattingRule(key: .foregroundColor, value: NSColor.accent)
        ])]
    }
    var body: some View {
        ScrollView {
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
                
                Picker("", selection: $selectedTab) {
                    ForEach(Tab.allCases, id: \.self) { tab in
                        Text(tab.rawValue)
                            .tag(tab)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 20)
                
                Divider()
                    .padding(.vertical, 10)
                
                Group {
                    switch selectedTab {
                    case .parameters:
                        InputParametersListView(inputParameters: $prompt.inputParameters)
                    case .prompt:
                        VStack(spacing: 10) {
                            TextField("Enter title", text: $prompt.title)
                                .font(.headline)
                                .foregroundStyle(Color.accentColor)
                            
                            Divider()
                            
                            ZStack(alignment: .topLeading) {
                                HighlightedTextEditor(text: $prompt.placeholderText, highlightRules: rules)
                                // optional modifiers
                                    .onCommit { print("commited") }
                                    .onEditingChanged { print("editing changed") }
                                    .onTextChange { print("latest text value", $0) }
                                    .onSelectionChange { (range: NSRange) in
                                        print(range)
                                    }
                                    .introspect { editor in
                                        // access underlying UITextView or NSTextView
                                        editor.textView.backgroundColor = NSColor(Color.backgroundGrey)
                                    }
                                    .frame(height: 100)
                                    .padding(.leading, -5)
                                
                                if prompt.placeholderText == "" {
                                    Text("Enter your prompt")
                                        .foregroundColor(Color(.tertiaryLabelColor))
                                        .padding(.top, -0.5)
                                        .allowsHitTesting(false)
                                    
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
                        .background(.backgroundGrey)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .font(.body)
                        
                        Spacer()
                        
                        HStack(spacing: 10) {
                            Button("Fertig") {
                                if prompt.title != "" && prompt.placeholderText != "" {
                                    prompt.inputParameters.removeAll { $0.parameterName.isEmpty }
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
        }
    }
}

#Preview {
    NewPromptView(presented: .constant(true))
}
