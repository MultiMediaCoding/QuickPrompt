import SwiftUI

struct PromptLibraryPane: View {
    
    @State private var searchText = ""
    @State private var newPromptSheet = false
    
    @EnvironmentObject var cloudkitViewModel: CloudKitViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
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
            .onChange(of: searchText) { searchText in
                Task {
                    await cloudkitViewModel.searchPrompts(searchText: searchText)
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
        if searchText.isEmpty {
            return cloudkitViewModel.prompts
        } else {
            return cloudkitViewModel.searchResults
        }
    }
}


struct WhatsUpPane_Previews: PreviewProvider {
    static var previews: some View {
        PromptLibraryPane()
    }
}
