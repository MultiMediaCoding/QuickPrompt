//
//  GroupedBox.swift
//  QuickPrompt
//
//  Created by Hans Poreda on 06.12.24.
//

import SwiftUI

struct GroupedBox<Content: View>: View {
    let title: String?
    let content: () -> Content
    
    init(title: String? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.title = title
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let title {
                GroupedBoxTitle(title: title)
            }
            
            GroupBox {
                content()
                    .padding(5)
            }
        }
    }
}
