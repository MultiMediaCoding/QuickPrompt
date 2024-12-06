//
//  Prompt.swift
//  QuickPrompt App
//
//  Created by Lovis on 16.12.24.
//

import SwiftUI
import CloudKit

struct Prompt: Identifiable, Hashable {
    let id: String
    var title: String
    var text: String
    var category: Category
    var createdDate: Date
    
    enum Category: String {
        case Education
        case Developers
        case Fun
        case PreciseAwnsers
        case Lists
    }
    
    init(id: String = UUID().uuidString, title: String, text: String, category: Category, createdDate: Date = Date()) {
        self.id = id
        self.title = title
        self.text = text
        self.category = category
        self.createdDate = createdDate
    }
}

enum PromptRecordKeys: String {
    case type = "Prompt"
    case title
    case text
    case category
    case createdDate
}

extension Prompt {
    var record: CKRecord {
        let record = CKRecord(recordType: PromptRecordKeys.type.rawValue)
        record[PromptRecordKeys.title.rawValue] = self.title
        record[PromptRecordKeys.text.rawValue] = self.text
        record[PromptRecordKeys.category.rawValue] = self.category.rawValue
        record[PromptRecordKeys.createdDate.rawValue] = self.createdDate as CKRecordValue
        return record
    }
    
    init?(from record: CKRecord) {
        let id = record.recordID.recordName
        
        guard
            let title = record[PromptRecordKeys.title.rawValue] as? String,
            let text = record[PromptRecordKeys.text.rawValue] as? String,
            let category = record[PromptRecordKeys.category.rawValue] as? String,
            let createdDate = record[PromptRecordKeys.createdDate.rawValue] as? Date
        else { return nil }
        
        self = .init(id: id, title: title, text: text, category: Prompt.Category(rawValue: category) ?? .PreciseAwnsers, createdDate: createdDate)
    }
}
