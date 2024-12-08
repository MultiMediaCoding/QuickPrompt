import SwiftUI

struct AboutSettingsTab: View {
    
    let icon: NSImage?
    let name: String
    let version: String
    let build: String
    let copyright: String
    let developerName: String
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack(alignment: .firstTextBaseline) {
                    Text(name)
                        .font(.title)
                        .bold()
                    Spacer()
                    Text("Version \(version)") + Text(" (\(build))")
                }
                Divider()
                    .padding(.top, -4)
                    .padding(.bottom, 4)
            }
            .padding(.top, 5)
            
            HStack(alignment: .top, spacing: 15) {
                Image(nsImage: icon ?? NSImage(named: NSImage.folderName)!)
                    .scaledToFit()
                
                VStack(alignment: .leading, spacing: 3) {
                    Text("Developed by")
                        .bold()
                    Text(developerName)
                    Text(copyright)
                        .font(.system(size: 10))
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(20)
    }
}
