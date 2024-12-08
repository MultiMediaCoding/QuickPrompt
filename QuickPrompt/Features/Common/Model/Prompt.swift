//
//  Prompt.swift
//  QuickPrompt App
//
//  Created by Lovis on 16.12.24.
//

import SwiftUI
import CloudKit


struct Prompt: Identifiable, Hashable, Codable {
    let id: String
    var icon: String { promptSymbols[category.rawValue] ?? "text.alignleft" }
    var title: String
    var defaultText: String
    var placeholderText: String
    var text: String {
        var text = placeholderText
        
        for parameter in inputParameters {
            text = text.replacingOccurrences(of: parameter.parameterName, with: parameter.parameterValue)
        }
        
        return text
    }
    var category: Category
    var inputParameters: [InputParameter]
    var createdDate: Date
    
    enum Category: String, CaseIterable, Hashable, Codable {
        case All = "Alle Prompts"
        case Education
        case Lists
        case Developers
        case Fun
        case PreciseAwnsers = "Precise Awnsers"
    }
    
    // Optional: Custom coding keys if needed for different JSON keys
    enum CodingKeys: String, CodingKey {
        case id, title, defaultText, placeholderText, category, inputParameters, createdDate
    }
}


enum PromptRecordKeys: String {
    case type = "Prompt"
    case title
    case placeholderJson
    case category
}

extension Prompt {
    var record: CKRecord {
        let record = CKRecord(recordType: PromptRecordKeys.type.rawValue)
        record[PromptRecordKeys.title.rawValue] = self.title
        record[PromptRecordKeys.placeholderJson.rawValue] = self.generatePlaceholderTextJSON()
        record[PromptRecordKeys.category.rawValue] = self.category.rawValue
        return record
    }
    
    init?(from record: CKRecord) {
        
        guard
            let title = record[PromptRecordKeys.title.rawValue] as? String,
            let placeholderJson = record[PromptRecordKeys.placeholderJson.rawValue] as? String,
            let placeholderText = parsePlaceholderText(from: placeholderJson),
            let inputParameters = parseInputParameters(from: placeholderJson),
            let category = record[PromptRecordKeys.category.rawValue] as? String,
                let createdDate = record.creationDate
        else { return nil }
        
        let id = record.recordID.recordName
        
        var defaultText = placeholderText
        for inputParameter in inputParameters {
            defaultText = defaultText.replacingOccurrences(of: inputParameter.parameterName, with: inputParameter.parameterDefaultValue)
        }
        
        self = .init(id: id, title: title, defaultText: defaultText, placeholderText: placeholderText, category: Prompt.Category(rawValue: category) ?? .All, inputParameters: inputParameters, createdDate: createdDate)
    }
    
    func generatePlaceholderTextJSON() -> String? {
        let promptDict: [String: Any] = [
            "placeholderText": self.placeholderText,
            "inputParameters": self.inputParameters.map { inputParameter in
                return [
                    "parameterName": inputParameter.parameterName,
                    "parameterDescription": inputParameter.parameterDescription,
                    "parameterDefaultValue": inputParameter.parameterDefaultValue,
                    "parameterValue": inputParameter.parameterValue
                ]
            }
        ]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: promptDict, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            return jsonString
        }
        
        return nil
    }
}

func parsePlaceholderText(from json: String) -> String? {
    if let data = json.data(using: .utf8),
       let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
       let placeholderText = jsonObject["placeholderText"] as? String {
        return placeholderText
    }
    return nil
}

func parseInputParameters(from json: String) -> [InputParameter]? {
    if let data = json.data(using: .utf8),
       let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
       let inputParametersArray = jsonObject["inputParameters"] as? [[String: Any]] {
        
        var inputParameters: [InputParameter] = []
        
        for param in inputParametersArray {
            if let parameterName = param["parameterName"] as? String,
               let parameterDescription = param["parameterDescription"] as? String,
               let parameterDefaultValue = param["parameterDefaultValue"] as? String,
               let parameterValue = param["parameterValue"] as? String {
                let inputParameter = InputParameter(
                    parameterName: parameterName,
                    parameterDescription: parameterDescription,
                    parameterDefaultValue: parameterDefaultValue,
                    parameterValue: parameterValue
                )
                inputParameters.append(inputParameter)
            }
        }
        
        return inputParameters
    }
    return nil
}
