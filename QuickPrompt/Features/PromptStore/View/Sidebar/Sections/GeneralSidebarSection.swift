import SwiftUI

struct GeneralSidebarSection: View {
    
    @Binding var selection: SidebarPane?
    
    @StateObject var viewModel = CloudKitService()
    
    var body: some View {
        
        Section(header: Text("Persönliche Prompts")) {
            if viewModel.prompts.isEmpty {
                HStack{
                    Spacer()
                    ProgressView()
                        .scaleEffect(0.5)
                    Spacer()
                }
            } else {
                ForEach(viewModel.prompts) { prompt in
                    NavigationLink {
                        PromptDetailPane(prompt: prompt, formattedDate: viewModel.formatDate(prompt.createdDate))
                    } label: {
                        SidebarListElement(prompt: prompt)
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.getPrompts()
            }
        }
    }
}

struct GeneralSidebarSection_Previews: PreviewProvider {
    static var previews: some View {
        GeneralSidebarSection(selection: .constant(.helloWorld))
    }
}
