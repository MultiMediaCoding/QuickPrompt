import SwiftUI

struct MoreSidebarSection: View {
    
    @Binding var selection: SidebarPane?
    
    var body: some View {
                
        Section(header: Text("Library")) {
			
			NavigationLink {
                PromptLibraryPane()
			} label: {
                HStack{
                    Label("Prompt Library", systemImage: "sparkles.rectangle.stack")
                }
                .padding(.vertical, 4)
			}
			
        }
    }
}

struct MoreSidebarSection_Previews: PreviewProvider {
    static var previews: some View {
        MoreSidebarSection(selection: .constant(.moreStuff))
    }
}
