//
//  HomepageViewController.swift
//  GrappleGuide_v1.3
//
//  Created by connorsMac on 2024-03-05.
//

import Foundation
import Firebase

extension HomepageView {
    class homepageViewController: ObservableObject {
        
        @Published var selectedChoice = ""
        @Published var selectedDescription = ""
        @Published var isTechViewShown = false
        
        @Published var categories = [
            "POSITIONS",
            "TAKEDOWNS",
            "SUBMISSIONS",
            "SWEEPS"
        ]
        
        @Published var positions = [
            "Guard",
            "Open Guard",
            "Mount",
            "Back Mount",
            "Side Control",
            "Knee on Belly (KOB)",
            "North-South Position",
            "Turtle Position",
            "Standing"
        ]
        
        @Published var takedowns = [
            "Double Leg Takedown",
            "Single Leg Takedown",
            "High Crotch / Single Leg High Crotch",
            "Ankle Pick",
            "Fireman's Carry",
            "Sprawl and Spin Behind",
            "Duck Under",
            "Snap Down to Front Headlock",
            "Arm Drag",
            "Russian Tie / Two on One",
            "Slide-By",
            "Head Outside / Head Inside Single Leg",
            "Body Lock / Bear Hug Takedown",
            "Knee Tap",
            "Inside Trip"
        ]

        @Published var submissions = [
            "Armbar (Juji Gatame)",
            "Triangle Choke",
            "Kimura",
            "Rear Naked Choke (RNC)",
            "Americana (Keylock)",
            "Guillotine Choke (Arm in / out)",
            "Wristlock",
            "Omoplata",
            "Ezekiel Choke",
            "Darce / Andacona Choke",
            "Arm Triangle Choke (Kata Gatame)",
            "Toe Hold",
            "Kneebar",
            "Straight Ankle Lock",
            "Heel Hook"
        ]

        @Published var sweeps = [
            "Scissor Sweep (Xande Sweep)",
            "Flower Sweep (Foot on Hip Sweep)",
            "Hip Bump Sweep (Upa Sweep)",
            "Butterfly Sweep",
            "Elevator Sweep",
            "Spider Guard Sweep",
            "Hook Sweep (De La Riva Hook Sweep)",
            "X-Guard Sweep",
            "Pendulum Sweep",
            "Shin-on-Shin Sweep",
            "Electric Chair Sweep",
            "Spider Hook Sweep",
            "Half Guard Sweep (Old School Sweep)",
            "Sit-Up Sweep",
            "Deep Half Guard Sweep"
        ]

        
        func libcategory(category: String) {
            print("Selected choice", category)
            self.selectedChoice = category
            getTechDescription(tech: selectedChoice)
        }
        
        func getTechDescription(tech: String) {
            let db = Firestore.firestore()
            
            db.collection("techniques")
                .whereField("name", isEqualTo: tech)
                .getDocuments { querySnapshot, error in
                    if let error = error {
                        print("Error getting technique documents: \(error.localizedDescription)")
                        self.selectedDescription = ""
                        return
                    }
                    
                    guard let documents = querySnapshot?.documents else {
                        print("No matching Technique in DB")
                        self.selectedDescription = ""
                        return
                    }
                    
                    if let document = documents.first {
                        if let description = document.data()["description"] as? String {
                            self.selectedDescription = description
                        } else {
                            print("Description not found for technique")
                            self.selectedDescription = ""
                        }
                    } else {
                        print("No matching technique found in the DB")
                        self.selectedDescription = ""
                    }
            }
        }
        
    }
}
