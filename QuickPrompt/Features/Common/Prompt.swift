//
//  Prompt.swift
//  QuickPrompt
//
//  Created by Hans Poreda on 06.12.24.
//

import Foundation

struct Prompt: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let systemName: String
    let text: String
}

let testPrompts: [Prompt] = [
    Prompt(
        title: "Ideen generieren",
        systemName: "lightbulb",
        text: "Hilf mir, kreative Ideen für eine neue App-Funktion zu entwickeln, die auf Benutzerpräferenzen basiert."
    ),
    Prompt(
        title: "Code Review",
        systemName: "doc.text.magnifyingglass",
        text: "Analysiere diesen Swift-Code und schlage Optimierungen vor. Achte auf Lesbarkeit, Performance und Best Practices."
    ),
    Prompt(
        title: "Fehlersuche",
        systemName: "ant",
        text: "Hier ist ein Bug in meinem Swift-Code. Beschreibe mögliche Ursachen und wie ich ihn beheben kann."
    ),
    Prompt(
        title: "UI/UX Beratung",
        systemName: "paintpalette",
        text: "Gib Vorschläge, wie ich die Benutzeroberfläche meiner App verbessern kann, um die Navigation intuitiver zu gestalten."
    ),
    Prompt(
        title: "Debugging-Strategien",
        systemName: "wrench.and.screwdriver",
        text: "Welche Schritte sollte ich unternehmen, um eine App zu debuggen, die in bestimmten Fällen abstürzt?"
    ),
    Prompt(
        title: "Dokumentation schreiben",
        systemName: "book",
        text: "Hilf mir, eine klare und verständliche Dokumentation für die Funktionalitäten meiner App zu schreiben."
    ),
    Prompt(
        title: "Benutzerfeedback analysieren",
        systemName: "person.2.fill",
        text: "Analysiere dieses Benutzerfeedback und schlage Prioritäten für die nächsten Entwicklungszyklen vor."
    ),
    Prompt(
        title: "Testfälle erstellen",
        systemName: "checkmark.seal",
        text: "Hilf mir, Testfälle für die Unit-Tests meiner App zu definieren, die verschiedene Szenarien abdecken."
    )
]
