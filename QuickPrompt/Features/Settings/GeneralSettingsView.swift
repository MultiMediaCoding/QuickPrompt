import SwiftUI

struct GeneralSettingsTab: View {

    @AppStorage("settings.showMenuBarApp") private var showMenuBarApp: Bool = true
    @StateObject private var promptsViewModel = PromptsViewModel()
    
    @State private var showingDeleteAlert = false

    var body: some View {
        Form {
            HStack{
                VStack(alignment: .leading, spacing: 25){
                    VStack(alignment: .leading) {
                        Text("Menu Bar App")
                            .font(.headline)
                        Toggle("Show Menu Bar App", isOn: $showMenuBarApp)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Manage Bookmarks")
                            .font(.headline)
                        
                        Button(role: .destructive) {
                            showingDeleteAlert = true
                        } label: {
                            Label("Delete All Bookmarks", systemImage: "trash")
                        }
                        .foregroundStyle(.red)
                        
                        Text("This action cannot be undone.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
                Spacer()
            }
            .padding(20)
        }
        .alert(isPresented: $showingDeleteAlert) {
            Alert(
                title: Text("Delete All Bookmarks"),
                message: Text("Are you sure you want to delete all bookmarks? This action cannot be undone."),
                primaryButton: .destructive(Text("Delete")) {
                    promptsViewModel.deleteAllPrompts()
                },
                secondaryButton: .cancel()
            )
        }
    }
}

struct GeneralSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralSettingsTab()
    }
}
