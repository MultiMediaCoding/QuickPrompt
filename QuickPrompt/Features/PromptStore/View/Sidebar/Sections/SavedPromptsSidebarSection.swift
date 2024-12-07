import SwiftUI

struct SavedPromptsSidebarSection: View {
    
    @Binding var selection: SidebarPane?
    var body: some View {
                
        Section(header: Text("Persönlich")) {
			
			NavigationLink {
                SavedPromptsPane()
			} label: {
                HStack{
                    Label("Gespeichert", systemImage: "bookmark")
                }
                .padding(.vertical, 4)
			}
			
        }
    }
}

struct MoreSidebarSection_Previews: PreviewProvider {
    static var previews: some View {
        SavedPromptsSidebarSection(selection: .constant(.moreStuff))
    }
}
