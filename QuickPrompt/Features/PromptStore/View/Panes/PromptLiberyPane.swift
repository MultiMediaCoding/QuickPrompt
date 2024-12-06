import SwiftUI

struct PromptLibraryPane: View {
    // Sample Data
    let gptPromptsLibrary: [Prompt] = [
        Prompt(title: "Improve Time Management", text: "Discover tips and techniques to manage your time efficiently.", category: .Education),
        Prompt(title: "Effective Workplace Communication", text: "Learn how to communicate effectively in professional settings.", category: .Developers),
        Prompt(title: "AI in Medicine", text: "Explore the impact of artificial intelligence in modern healthcare.", category: .Education),
        Prompt(title: "Successful E-commerce Business", text: "Understand the key elements of running a successful e-commerce business.", category: .Lists),
        Prompt(title: "Understanding Blockchain Technology", text: "A guide to understanding how blockchain works and its applications.", category: .Education)
    ]
    
    @State private var searchText = ""
    
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
            .navigationTitle("Library")
        }
    }
    
    var searchResults: [Prompt] {
        if searchText.isEmpty {
            return gptPromptsLibrary
        } else {
            return gptPromptsLibrary.filter { $0.title.contains(searchText) }
        }
    }
}


struct WhatsUpPane_Previews: PreviewProvider {
    static var previews: some View {
        PromptLibraryPane()
    }
}
