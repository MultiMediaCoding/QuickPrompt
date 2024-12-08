//
//  HighlightTextView.swift
//  QuickPrompt
//
//  Created by Hans Poreda on 08.12.24.
//

import SwiftUI

struct HighlightedText: View {
    let inputText: String
    let keywords: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            GroupedBoxTitle(title: "Dein Prompt")
                .padding(.leading)
                .padding(.bottom, -5)
            
            VStack(alignment: .leading) {
                if inputText.isEmpty {
                    Text("Kein Text")
                        .foregroundStyle(.secondary)
                }
                else {
                    Text(buildAttributedString())
                        .font(.body)
                }
            }
            .textFieldStyle(.plain)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .padding(.horizontal)
            .font(.body)
        }
        .padding(.vertical)
    }
    
    private func buildAttributedString() -> AttributedString {
        var attributedString = AttributedString()
        
        // Regex für Wörter mit optionalen Satzzeichen
        let pattern = "\\b\\w+[.,!?']*\\b"
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(inputText.startIndex..., in: inputText)
        
        if let matches = regex?.matches(in: inputText, range: range) {
            var lastEnd = inputText.startIndex
            
            for match in matches {
                if let range = Range(match.range, in: inputText) {
                    // Text vor dem Match hinzufügen
                    if lastEnd < range.lowerBound {
                        let preText = inputText[lastEnd..<range.lowerBound]
                        attributedString.append(AttributedString(String(preText)))
                    }
                    
                    // Matched Wort extrahieren und Satzzeichen entfernen für Vergleich
                    let matchedWord = String(inputText[range])
                    let cleanWord = matchedWord.trimmingCharacters(in: .punctuationCharacters)
                    
                    if keywords.contains(cleanWord) {
                        var highlightedWord = AttributedString(matchedWord)
                        highlightedWord.foregroundColor = .blue
                        highlightedWord.font = .bold(.body)()
                        attributedString.append(highlightedWord)
                    } else {
                        attributedString.append(AttributedString(matchedWord))
                    }
                    
                    lastEnd = range.upperBound
                }
            }
            
            // Restlichen Text hinzufügen
            if lastEnd < inputText.endIndex {
                let remainingText = inputText[lastEnd...]
                attributedString.append(AttributedString(String(remainingText)))
            }
        }
        
        return attributedString
    }
}


#Preview {
    //HighlightedText()
}
