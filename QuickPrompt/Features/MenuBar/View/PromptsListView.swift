//
//  PromptsListView.swift
//  QuickPrompt
//
//  Created by Hans Poreda on 06.12.24.
//

import SwiftUI

struct PromptsListView: View {
    @EnvironmentObject var viewModel: MenuBarViewModel
    @EnvironmentObject var cloudKitViewModel: CloudKitViewModel
    var body: some View {
        if cloudKitViewModel.prompts.isEmpty {
            ProgressView()
        }
        else {
            VStack(alignment: .leading){
                ForEach(cloudKitViewModel.prompts, id: \.self) { prompt in
                    PromptListItem(prompt: prompt)
                }
            }
        }
    }
}

#Preview {
    PromptsListView()
}
