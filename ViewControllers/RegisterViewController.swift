//
//  RegisterViewController.swift
//  GrappleGuide_v1.3
//
//  Created by connorsMac on 2024-02-27.
//

import Foundation
import SwiftUI
import Firebase

class registerViewController: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var realname: String = ""
    @Published var trainingAge: String = ""
    @Published var birthDate = Date()
    @Published var profileImage: UIImage? = nil
    
    let minDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())!
    let maxDate = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
    
    @Published var backgroundColor = Color.white
    @Published var UIbackgroundColor = UIColor.white
    
    @Published var presentCreateProfileView = false
    @Published var profileCreated = false
    @Published var profilePictureView = false
    
    func confirmSelected() {
        presentCreateProfileView = true
    }
    
    func dismissCreateProfileView() {
        presentCreateProfileView = false
        profileCreated = true
    }
    
    func create() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error saving user data: \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else {
                print("Error: User object is nil.")
                return
            }
            
            guard let imageData = self.profileImage?.jpegData(compressionQuality: 0.5) else {
                print("Error converting image to data")
                return
            }
            
            self.saveProfile(forUser: user, imageData: imageData)
        }
    }
    
    func saveProfile(forUser user: User, imageData: Data) {
        
        let UIbackgroundColor = backgroundColor.toUIColor()
        
        let userData: [String: Any] = [
            "uid": user.uid,
            "displayName": username,
            "email": email,
            "realName": realname,
            "birthDate": birthDate,
            "favouriteColor" : UIbackgroundColor.hexString,
            "experience": trainingAge,
            "profileImageData": imageData
        ]
        
        let db = Firestore.firestore()
        
        db.collection("users").document(user.uid).setData(userData) { error in
            if let error = error {
                print("Error saving user data: \(error.localizedDescription)")
            }
        }
    }
}
