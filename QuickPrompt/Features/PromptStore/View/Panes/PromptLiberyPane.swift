import SwiftUI

struct PromptLibraryPane: View {
    
    let category: Prompt.Category
    
    @State private var searchText = ""
    @State private var newPromptSheet = false
    
   @EnvironmentObject var cloudkitViewModel: CloudKitViewModel
    
    var body: some View {
        NavigationStack {
            
            if searchResults.isEmpty {
                VStack{
                    Spacer()
                    Text("Diese Kategorie ist noch leer")
                        .foregroundStyle(.secondary)
                }
            }
            
            GeometryReader { geometry in
                ScrollView {
                    let columns = adaptiveColumns(for: geometry.size.width)
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(searchResults, id: \.self) { prompt in
                            LibraryGridItem(prompt: prompt)
                        }
                    }
                    .padding()
                }
                .searchable(
                    text: $searchText,
                    placement: .toolbar,
                    prompt: "Search",
                    suggestions: {
                        if searchResults.count < 5 {
                            ForEach(searchResults, id: \.self) { result in
                                Text(result.title)
                                    .searchCompletion(result.title)
                            }
                        }
                    }
                )
                .task {
                    await cloudkitViewModel.getPrompts()
                }
                .onChange(of: searchText) { searchText in
                    Task {
                        await cloudkitViewModel.searchPrompts(searchText: searchText)
                    }
                }
            }
            .navigationTitle("Library")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button {
                        newPromptSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $newPromptSheet) {
                NewPromptView(presented: $newPromptSheet)
                    .frame(width: 600)
            }
        }
    }
    
    var searchResults: [Prompt] {
        if category == .All {
            return searchText.isEmpty ? cloudkitViewModel.prompts : cloudkitViewModel.searchResults
        } else {
            if searchText.isEmpty {
                return cloudkitViewModel.prompts.filter { $0.category == self.category }
            } else {
                return cloudkitViewModel.searchResults.filter { $0.category == self.category }
            }
        }
    }
    
    private func adaptiveColumns(for width: CGFloat) -> [GridItem] {
        let columnCount = max(1, Int(width / 200))
        return Array(repeating: GridItem(.flexible()), count: columnCount)
    }
}


struct WhatsUpPane_Previews: PreviewProvider {
    static var previews: some View {
        PromptLibraryPane(category: Prompt.Category.Education)
    }
}
