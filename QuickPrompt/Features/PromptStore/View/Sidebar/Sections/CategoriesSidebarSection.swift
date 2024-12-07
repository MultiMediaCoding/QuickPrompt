import SwiftUI

struct CategoriesSidebarSection: View {
    
    @Binding var selection: SidebarPane?
    @EnvironmentObject var promptsViewModel: PromptsViewModel
    @EnvironmentObject var cloudKitViewModel: CloudKitViewModel
    
    var body: some View {
        
        Section("Library") {
            
            ForEach(Prompt.Category.allCases, id: \.self) { category in
                    NavigationLink {
                        PromptLibraryPane(category: category)
                    } label: {
                        SidebarListElement(category: category.rawValue)
                            
                    }
                }
        }
    }
}

struct GeneralSidebarSection_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesSidebarSection(selection: .constant(.helloWorld))
    }
}

