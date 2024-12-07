//
//  QuickPromptViewModel.swift
//  AirCaptain
//
//  Created by Lovis Steinmayer on 06.12.24.
//

import SwiftUI
import CloudKit

class CloudKitViewModel: ObservableObject {
    
    @Published var prompts = [Prompt]()
    
    private let database = CKContainer.default().publicCloudDatabase
    private let defaultPredicate = NSPredicate(value: true)
    
    init() {
        Task {
            await getPrompts()
        }
    }
    
    func getPrompt(for recordID: CKRecord.ID) async -> Prompt? {
        guard let record = await getRecord(for: recordID) else { return nil }
        
        return Prompt.init(from: record)
    }
    
    func getPrompts() async {
        let query = CKQuery(recordType: PromptRecordKeys.type.rawValue, predicate: defaultPredicate)
        
        do {
            let response = try await database.records(matching: query)
            let records = response.matchResults.compactMap { try? $0.1.get() }
            let prompts = records.compactMap(Prompt.init)
            withAnimation(.spring){
                DispatchQueue.main.async {
                    self.prompts = prompts
                }
            }
        }
        catch {
            print(error.localizedDescription)
        }
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
      
    
    private func getRecord(for recordID: CKRecord.ID) async -> CKRecord? {
        do {
            let record = try await database.record(for: recordID)
            return record
        }
        catch {
            print("Error fetching record: \(error.localizedDescription)")
        }
        
        return nil
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
    
    
    func formatDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "de_DE")
            formatter.dateStyle = .long
            return formatter.string(from: date)
        }
}

extension CloudKitViewModel {
    func save(_ record: CKRecord) async throws {
        try await CKContainer.default().privateCloudDatabase.save(record)
    }
}
