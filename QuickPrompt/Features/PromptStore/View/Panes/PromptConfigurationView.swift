//
//  PromptConfigurationView.swift
//  QuickPrompt
//
//  Created by Hans Poreda on 08.12.24.
//

import SwiftUI

struct PromptConfigurationView: View {
    @State private var prompt: Prompt
    @Binding var isPresented: Bool
    
    @EnvironmentObject var viewModel: PromptsViewModel
    
    init(prompt: Prompt, isPresented: Binding<Bool>) {
        self._prompt = State(initialValue: prompt)
        self._isPresented = isPresented
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                ForEach($prompt.inputParameters, id: \.id) { $inputParameter in
                    VStack(alignment: .leading) {
                        Text(inputParameter.parameterName)
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        Text(inputParameter.parameterDescription)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .padding(.bottom, 6)
                        
                        TextField(inputParameter.parameterDefaultValue, text: $inputParameter.parameterValue)
                            .foregroundStyle(Color.accentColor)
                            .textFieldStyle(.plain)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)
                            .font(.body)
                    }
                    .padding(.bottom, 24)
                }
                
                Button {
                    viewModel.savePrompt(prompt)
                    isPresented.toggle()
                } label: {
                    Label("Prompt hinzufügen", systemImage: "plus.circle.fill")
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 35)
                        .background(Color.accentColor)
                        .cornerRadius(8)
                }
                .buttonStyle(.plain)
            }
            .padding()
            .frame(minHeight: 200)
            .navigationTitle("Prompt Konfigurieren")
        }
    }
}
