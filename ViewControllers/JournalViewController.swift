//
//  JournalViewController.swift
//  GrappleGuide_v1.3
//
//  Created by connorsMac on 2024-03-21.
//

import Foundation
import SwiftUI
import Firebase

extension JournalView {
    class journalViewController: ObservableObject {
        
        let customLightGray = Color(red: 0.9, green: 0.9, blue: 0.9)
        
        struct Journal: Identifiable {
            let id = UUID()
            let name: String
            let description: String
        }
        
        @Published var journals: [Journal] = []
        @Published var selectedJournal: Journal?
        @Published var isShowingJournalEntry = false
        @Published var isShowingJournalEditor = false
        @Published var isShowingAlert = false
        
        init() {
            fetchJournals()
        }
        
        func fetchJournals() {
            let db = Firestore.firestore()
            
            db.collection("journals").getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching documents: \(error.localizedDescription)")
                    return
                }
                
                guard let snapshot = snapshot else {
                    print("Snapshot is nil")
                    return
                }
                
                self.journals = snapshot.documents.compactMap { document in
                    let title = document.data()["title"] as? String ?? ""
                    let description = document.data()["description"] as? String ?? ""
                    return Journal(name: title, description: description)
                }
            }
        }
        
        func deleteJournal(journalName: String) {
            let db = Firestore.firestore()
            
            let query = db.collection("journals").whereField("title", isEqualTo: journalName)
            
            query.getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching document: \(error.localizedDescription)")
                    return
                }
                guard let snapshot = snapshot else {
                    print("Snapshot is nil")
                    return
                }
                
                if let document = snapshot.documents.first {
                    document.reference.delete { error in
                        if let error = error {
                            print("Error deleting document: \(error.localizedDescription)")
                        } else {
                            print("Document deleted successfully")
                            if let index = self.journals.firstIndex(where: { $0.name == journalName }) {
                                self.journals.remove(at: index)
                            }
                        }
                    }
                } else {
                    print("Journal with name '\(journalName)' could not be found in the database")
                }
            }
        }
    }
}
