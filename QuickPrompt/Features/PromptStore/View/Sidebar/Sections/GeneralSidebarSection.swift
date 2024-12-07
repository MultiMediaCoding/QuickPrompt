import SwiftUI

struct GeneralSidebarSection: View {
    
    @Binding var selection: SidebarPane?
    @EnvironmentObject var promptsViewModel: PromptsViewModel
    @EnvironmentObject var cloudKitViewModel: CloudKitViewModel
    
    var body: some View {
        
        Section("Persönliche Prompts") {
            if promptsViewModel.prompts.isEmpty {
                Text("Keine Prompts")
            }
            else {
                ForEach(promptsViewModel.savedPrompts, id: \.self) { prompt in
                    NavigationLink {
                        PromptDetailPane(prompt: prompt, formattedDate: cloudKitViewModel.formatDate(prompt.createdDate))
                    } label: {
                        SidebarListElement(prompt: prompt)
                            .contextMenu {
                                Button("Löschen") {
                                    promptsViewModel.deletePrompt(prompt)
                                }
                                .keyboardShortcut(.delete)
                            }
                    }
                }
            }
        }
    }
}

struct GeneralSidebarSection_Previews: PreviewProvider {
    static var previews: some View {
        GeneralSidebarSection(selection: .constant(.helloWorld))
    }
}
