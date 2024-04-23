//
//  JournalEntryViewController.swift
//  GrappleGuide_v1.3
//
//  Created by connorsMac on 2024-03-06.
//

import Foundation
import SwiftUI
import Firebase

extension JournalEntryView {
    class journalEntryViewController: ObservableObject {
        
        let customLightGray = Color(red: 0.9, green: 0.9, blue: 0.9)
        
        @Published var journalTitle = ""
        @Published var journalDescription = ""
        
        func submitJournal() {
            
            guard !journalTitle.isEmpty, !journalDescription.isEmpty else {
                print("Please enter a title and/or description for the journal")
                return
            }
            
            let db = Firestore.firestore()
            
            db.collection("journals").whereField("title", isEqualTo: journalTitle).getDocuments { snapshot, error in
                if let error = error {
                    print("Error checking document: \(error.localizedDescription)")
                    return
                }
                
                guard let snapshot = snapshot else {
                    print("Snapshot is nil")
                    return
                }
                
                if let existingJournalDoc = snapshot.documents.first {
                    // If a journal with the same title exists, update its description and timestamp
                    let journalDocRef = existingJournalDoc.reference
                    journalDocRef.updateData([
                        "description": self.journalDescription,
                        "timestamp": Date()
                    ]) { error in
                        if let error = error {
                            print("Error updating document: \(error.localizedDescription)")
                        } else {
                            print("Document updated successfully")
                            self.journalTitle = ""
                            self.journalDescription = ""
                        }
                    }
                } else {
                    // If no journal with the same title exists, add a new document
                    db.collection("journals").addDocument(data: [
                        "title": self.journalTitle,
                        "description": self.journalDescription,
                        "timestamp": Date()
                    ]) { error in
                        if let error = error {
                            print("Error adding document: \(error.localizedDescription)")
                        } else {
                            print("Document added successfully")
                            self.journalTitle = ""
                            self.journalDescription = ""
                        }
                    }
                }
            }
        }
    }
}
