//
//  PlainButton.swift
//  QuickPrompt
//
//  Created by Hans Poreda on 11.12.24.
//

import SwiftUI

struct PlainButton: View {
    let action: () -> Void
    var body: some View {
        Button("") {
            action()
        }
        .buttonStyle(.plain)
        .frame(width: 0, height: 0)
    }
}


#Preview {
    PlainButton { }
}
