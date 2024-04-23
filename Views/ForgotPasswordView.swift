//
//  ForgotPasswordView.swift
//  GrappleGuide_v1.3
//
//  Created by connorsMac on 2024-04-18.
//

import SwiftUI
import Firebase

struct ForgotPasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var userEmail = ""
    
    var body: some View {
        Text("Forgot Password")
            .font(.title)
            .padding()
        
        TextField("Email", text: $userEmail)
            .textFieldStyle(.roundedBorder)
            .textInputAutocapitalization(.none)
            .padding()
        
        Button("Send Reset Link") {
            Auth.auth().sendPasswordReset(withEmail: userEmail) { error in
                if let error = error {
                    print("Error sending password reset link \(error.localizedDescription)")
                } else {
                    print("Password reset email sent successfully")
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .buttonStyle(.bordered)
        .padding()
    }
}

#Preview {
    ForgotPasswordView()
}
