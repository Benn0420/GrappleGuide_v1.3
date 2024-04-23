//
//  AutenticateViewController.swift
//  GrappleGuide_v1.3
//
//  Created by connorsMac on 2024-02-27.
//

import Foundation
import SwiftUI
import Firebase

extension AuthenticateView {
    class authenticateViewController: ObservableObject {
        @Published var email = ""
        @Published var password = ""
        @Published var showAlert = false
        @Published var authenticationSuccess = false
        @Published var isForgotPassword = false
                
        func authenticate() {
            Auth.auth().signIn(withEmail: email, password: password){ result, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                if let user = Auth.auth().currentUser {
                    print("Signed in user: \(user.uid)")
                    self.showAlert = true
                }
            }
        }
        
        func loggedIn () {
            authenticationSuccess = true
        }
    }
}
