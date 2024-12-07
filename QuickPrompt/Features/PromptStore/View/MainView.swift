import SwiftUI
import WhatsNewKit

struct MainView: View {
    @AppStorage("showWelcomeSheet") var showWelcomeSheet = true
    @EnvironmentObject var promptsViewModel: PromptsViewModel
    
    var body: some View {
        NavigationView {
            if promptsViewModel.isLoading {
                ProgressView()
            }
            else {
                Sidebar()
                EmptyPane()
            }
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
