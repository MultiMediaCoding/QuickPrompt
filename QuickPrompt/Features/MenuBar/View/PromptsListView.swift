//
//  PromptsListView.swift
//  QuickPrompt
//
//  Created by Hans Poreda on 06.12.24.
//

import SwiftUI

struct PromptsListView: View {
    var body: some View {
        VStack(alignment: .leading){
            ForEach(testPrompts, id: \.self) { prompt in
                PromptListItem(prompt: prompt)
            }
        }
    }
}

#Preview {
    PromptsListView()
}
