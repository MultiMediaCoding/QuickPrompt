//
//  GroupedBoxTitle.swift
//  QuickPrompt
//
//  Created by Hans Poreda on 06.12.24.
//

import SwiftUI

struct GroupedBoxTitle: View {
    let title: String
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    GroupedBoxTitle(title: "Hali und Hallo")
}
