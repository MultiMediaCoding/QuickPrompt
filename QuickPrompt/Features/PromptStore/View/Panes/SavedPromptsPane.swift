import SwiftUI

struct SavedPromptsPane: View {
    
    @State private var searchText = ""
    
    @EnvironmentObject var cloudkitViewModel: CloudKitViewModel
    @EnvironmentObject var promptsViewModel: PromptsViewModel
    
    var body: some View {
        NavigationStack {
            
            if searchResults.isEmpty {
                VStack{
                    Spacer()
                    HStack(spacing: 4){
                        Text("Füge mit")
                        Image(systemName: "bookmark.fill")
                        Text("Prompts zu deiner persönlichen Sammlung hinzu")
                    }
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
            }
            .navigationTitle("Library")
        }
    }
    
    var searchResults: [Prompt] {
        if searchText.isEmpty {
            return promptsViewModel.savedPrompts
        } else {
            return promptsViewModel.savedPrompts.filter { prompt in
                prompt.title.localizedCaseInsensitiveContains(searchText) ||
                prompt.text.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    private func adaptiveColumns(for width: CGFloat) -> [GridItem] {
        let columnCount = max(1, Int(width / 200))
        return Array(repeating: GridItem(.flexible()), count: columnCount)
    }
}
