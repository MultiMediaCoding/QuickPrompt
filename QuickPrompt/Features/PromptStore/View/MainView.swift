import SwiftUI

struct MainView: View {
    
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
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
