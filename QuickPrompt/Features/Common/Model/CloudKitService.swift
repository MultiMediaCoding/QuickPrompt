//
//  CloudKitService.swift
//  QuickPrompt
//
//  Created by Hans Poreda on 07.12.24.
//

import CloudKit

class CloudKitService {
    static let shared = CloudKitService()
    private let database = CKContainer.default().publicCloudDatabase
    
    func searchPrompts(searchText: String) async -> [Prompt]? {
        let predicate = NSPredicate(format: "title BEGINSWITH %@", searchText)
        let prompts = await getPrompts(predicate: predicate)
        return prompts
    }
    
    func getPrompts(predicate: NSPredicate = NSPredicate(value: true)) async -> [Prompt]? {
        let query = CKQuery(recordType: PromptRecordKeys.type.rawValue, predicate: predicate)
        
        do {
            let response = try await database.records(matching: query)
            let records = response.matchResults.compactMap { try? $0.1.get() }
            let prompts = records.compactMap(Prompt.init)
            
            return prompts
        }
        catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func getPromptsByIds(for recordIDs: [CKRecord.ID]) async -> [Prompt]? {
        do {
            let response = try await database.records(for: recordIDs)
            let records = response.compactMap { try? $0.1.get() }
            let prompts = records.compactMap(Prompt.init)
            return prompts
        }
        catch {
            print("Error fetching record: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    func save(_ prompt: Prompt) {
          let record = prompt.record
          database.save(record) { savedRecord, error in
              if let error = error {
                  print("Error saving record: \(error.localizedDescription)")
              } else {
                  print("Successfully saved record: \(savedRecord?.recordID.recordName ?? "Unknown")")
              }
          }
      }
    
    func deleteRecord(id: String) async {
        let recordID = CKRecord.ID(recordName: id)
        
        do {
            try await database.deleteRecord(withID: recordID)
        }
        catch {
            print("Error deleting record: \(error.localizedDescription)")
        }
    }
}

extension CloudKitService {
    func save(_ record: CKRecord) async throws {
        try await CKContainer.default().privateCloudDatabase.save(record)
    }
}
