//
//  MenuBarView.swift
//  QuickPrompt
//
//  Created by Hans Poreda on 06.12.24.
//

import SwiftUI

struct MenuBarView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                GroupedBox(title: "General") {
                    HStack {
                        Image(systemName: "sparkles.rectangle.stack")
                            .foregroundStyle(Color.accentColor)
                        
                        Text("Prompt Library")
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                }

                VStack(alignment: .leading) {
                    GroupedBoxTitle(title: "Your Prompts")
                    PromptsListView()
                }
            }
            .padding(15)
        }
    }
}
