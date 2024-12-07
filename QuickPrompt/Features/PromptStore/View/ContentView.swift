//
//  ContentView.swift
//  QuickPrompt
//
//  Created by Hans Poreda on 06.12.24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = CloudKitService()
    
    @State private var titleInput: String = ""
    @State private var textInput: String = ""
    
    var body: some View {
        VStack {
            VStack{
                TextField("Enter title", text: $titleInput)
                    .font(.headline)
                
                Divider()
                TextField("Enter prompt text", text: $textInput)
                    
            }
            .textFieldStyle(.plain)
            .padding()
            .background(.background)
            .cornerRadius(10)
            .padding(.horizontal)
            .font(.body)
            
            Button("Save new Prompt") {
                viewModel.save(Prompt(
                    title: titleInput,
                    text: textInput,
                    category: .Education
                ))
            }
            .padding()
            
            List(viewModel.prompts) { prompt in
                Text(prompt.title)
                    .font(.headline)
                    .padding(.vertical, 5)
            }
        }
        .padding()
    }
      
}

#Preview {
    ContentView()
}
