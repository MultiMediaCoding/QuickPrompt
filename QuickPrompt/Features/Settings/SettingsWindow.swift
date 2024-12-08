import SwiftUI

struct SettingsWindow: View {

    private enum Tabs: Hashable {
        case general
        case about
        case licenses
    }

    var body: some View {
        TabView {
            GeneralSettingsTab()
                .tabItem {
                    Label("General", systemImage: "gear")
                }
                .tag(Tabs.general)
            
            AboutSettingsTab(icon: NSImage(named: "Logo"), name: "Quick Prompt", version: "1.0", build: "1", copyright: "Squash Gbr", developerName: "Lovis Steinmayer & Hans Poreda")
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
                .tag(Tabs.about)
            
            
            LicensesSettingsTab()
                .tabItem {
                    Label("Licenses", systemImage: "doc.text")
                }
                .tag(Tabs.licenses)
        }
        .frame(width: 400, height: 190)
    }
    
    /// Show settings programmatically
    static func show() {
        NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
    }
}

struct SettingsWindow_Previews: PreviewProvider {
    static var previews: some View {
        SettingsWindow()
    }
}
