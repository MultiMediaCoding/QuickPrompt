import SwiftUI

struct AboutCommand: Commands {
    
    @State private var aboutWindow: NSWindow?

    var body: some Commands {
        CommandGroup(replacing: .appInfo) {
            Button {
                openAboutWindow()
            } label: {
                Text("About QuickPrompt")
            }
        }
    }
    
    private func openAboutWindow() {
        guard aboutWindow == nil else { return }

        let aboutView = AboutSettingsTab(
            icon: NSImage(named: "Logo"),
            name: "Quick Prompt",
            version: "1.0",
            build: "1",
            copyright: "Squash Gbr",
            developerName: "Lovis Steinmayer & Hans Poreda"
        ).padding()

        let hostingController = NSHostingController(rootView: aboutView)
        let window = NSWindow(contentViewController: hostingController)
        window.title = "About QuickPrompt"
        window.setContentSize(NSSize(width: 400, height: 300))
        window.center()
        window.makeKeyAndOrderFront(nil)
        
        aboutWindow = window
    }
}
