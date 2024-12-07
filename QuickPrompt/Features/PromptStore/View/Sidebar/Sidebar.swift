import SwiftUI

struct Sidebar: View {
        
    @State var selection: SidebarPane? = nil
    
    @State var searchText: String = ""
    
    var body: some View {
        List {
            SavedPromptsSidebarSection(selection: $selection)
            CategoriesSidebarSection(selection: $selection)
        }
        .listStyle(SidebarListStyle())
        .frame(minWidth: 180, idealWidth: 180, maxWidth: 300)
        .searchable(text: $searchText, placement: .sidebar)
        .toolbar {
            ToolbarItem {
                Button(action: toggleSidebar, label: {
                    Image(systemName: "sidebar.left")
                })
            }
        }
    }
}

private func toggleSidebar() {
    NSApp.keyWindow?
        .firstResponder?
        .tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
