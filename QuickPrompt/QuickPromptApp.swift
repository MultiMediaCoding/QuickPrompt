import SwiftUI

@main
struct QuickPromptApp: App {
    
    @AppStorage("settings.showMenuBarApp") private var showMenuBarApp: Bool = true
    
    @StateObject private var promptsViewModel: PromptsViewModel = .init()
    @StateObject private var cloudKitViewModel: CloudKitViewModel = .init()

    init() {
        NSApplication.shared.setActivationPolicy(.regular)
    }

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(promptsViewModel)
                .environmentObject(cloudKitViewModel)
        }
        .commands {
            AboutCommand()
        }
        
        Settings {
            SettingsWindow()
        }
        
        MenuBarExtra {
            MenuBarView()
                .environmentObject(promptsViewModel)
                .environmentObject(cloudKitViewModel)
                       .isHidden(!showMenuBarApp) //hiding the content
               } label: {
                   Image(systemName: "note.text")
                       .bold()
                       .font(.largeTitle)
                       .isHidden(!showMenuBarApp) //hiding the lable
               }
               .menuBarExtraStyle(.window)
            
    }
}

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
