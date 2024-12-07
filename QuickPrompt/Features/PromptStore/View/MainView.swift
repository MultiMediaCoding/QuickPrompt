import SwiftUI
import WhatsNewKit

struct MainView: View {
    @AppStorage("showWelcomeSheet") var showWelcomeSheet = true
    @StateObject var viewModel = CloudKitService()
    
    var body: some View {
        NavigationView {
            Sidebar()
            EmptyPane()
        }
        .environmentObject(viewModel)
        .task {
            await viewModel.getPrompts()
        }
        .sheet(isPresented: $showWelcomeSheet) {
            WhatsNewView(whatsNew: WhatsNewConfiguration.createWhatsNew {
                showWelcomeSheet = false
            }, versionStore: nil)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
