import SwiftUI

struct PromptDetailPane: View {
        
    let prompt: Prompt
    let formattedDate: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(prompt.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text(formattedDate)
                        .foregroundStyle(.secondary)
                    
                    Text(prompt.category.rawValue)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 30)
                
                GroupBox {
                    Text(prompt.text)
                        .padding()
                }
                .padding(.horizontal, 30)
                
                Spacer()
            }
            .padding(.top, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle("Prompt Details")
        .navigationSubtitle("Detailed View of the Prompt")
    }
}
