//
//  InputParameter.swift
//  QuickPrompt
//
//  Created by Hans Poreda on 08.12.24.
//

import Foundation

struct InputParameter: Identifiable, Hashable, Codable {
    let id: UUID
    var parameterName: String
    var parameterDescription: String
    var parameterDefaultValue: String
    var parameterValue: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case parameterName
        case parameterDescription
        case parameterDefaultValue
        case parameterValue
    }
    
    init(id: UUID = UUID(),
         parameterName: String,
         parameterDescription: String,
         parameterDefaultValue: String,
         parameterValue: String) {
        self.id = id
        self.parameterName = parameterName
        self.parameterDescription = parameterDescription
        self.parameterDefaultValue = parameterDefaultValue
        self.parameterValue = parameterValue
    }
}

