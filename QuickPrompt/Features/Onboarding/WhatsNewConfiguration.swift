//
//  WhatsNewConfiguration.swift
//  QuickPrompt
//
//  Created by Hans Poreda on 07.12.24.
//

import WhatsNewKit


struct WhatsNewConfiguration {
    static func createWhatsNew(onDismiss: @escaping () -> Void) -> WhatsNew {
        WhatsNew(
            version: "1.0.0",
            title: "Welcome to QuickPrompt",
            features: [
                .init(
                    image: .init(systemName: "text.justify.left", foregroundColor: .green),
                    title: "Fast & Effortless Access",
                    subtitle: "Save and instantly access all your prompts for everyday tasks."
                ),
                .init(
                    image: .init(systemName: "star.fill", foregroundColor: .orange),
                    title: "Organized by Categories",
                    subtitle: "Keep your prompts tidy with categories and matching icons."
                ),
                .init(
                    image: .init(systemName: "person.3.fill", foregroundColor: .blue),
                    title: "Share and Discover",
                    subtitle: "Store your prompts in a public database to inspire others and explore shared ideas."
                ),
            ],
            primaryAction: .init(
                title: "Continue",
                backgroundColor: .blue,
                foregroundColor: .white,
                onDismiss: onDismiss
            )
        )
    }

}
