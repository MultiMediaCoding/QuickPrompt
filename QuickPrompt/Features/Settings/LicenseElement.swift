//
//  LicensesListElement.swift
//  QuickPrompt
//
//  Created by Lovis Steinmayer on 08.12.24.
//

import SwiftUI

struct LicenseElement: View {
    var title: String
    var link: String
    var licenseText: String

    var body: some View {
        GroupBox {
            HStack(alignment: .top, spacing: 10) {
                Image(systemName: "shippingbox")
                    .font(.title)
                    .foregroundStyle(Color.accentColor)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    Text(link)
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    
                    Text(licenseText)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(.top, 10)
                }
            }
            .padding()
        }
    }
}
