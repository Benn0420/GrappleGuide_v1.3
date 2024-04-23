//
//  AuthenticateView.swift
//  GrappleGuide_v1.3
//
//  Created by connorsMac on 2024-02-27.
//

import SwiftUI

struct AuthenticateView: View {
    @StateObject var Avc = authenticateViewController()
    
    var body: some View {
        NavigationStack() {
            ZStack {
                Image("GrappleGuideBkrnd")
                    .resizable()
                    .cornerRadius(20)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 20) {
                    Spacer()
                    TextField("Email", text: $Avc.email)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                    SecureField("Password", text: $Avc.password)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .privacySensitive()
                    
                    HStack{
                        Spacer()
                        Button("FORGOT PASSWORD?", action: {
                            Avc.isForgotPassword.toggle()
                        })
                        .sheet(isPresented: $Avc.isForgotPassword){
                            ForgotPasswordView()
                        }
                        .tint(.gray.opacity(0.8))
                        .font(.system(size: 25, weight: .heavy))
                        Spacer()
                    }
                    
                    Spacer()
                        .frame(minHeight: 20, maxHeight: 30)
                    
                    HStack {
                        Spacer()
                        Button("LOGIN", action: Avc.authenticate)
                            .tint(.white)
                            .font(.system(size: 50, weight: .heavy))
                        Spacer()
                    }
                    Spacer()
                        .navigationDestination(isPresented: $Avc.authenticationSuccess) {
                            MainScreenView()
                                .navigationBarBackButtonHidden(true)
                        }
                }
            }
            .alert(isPresented: $Avc.showAlert) {
                Alert(title: Text("Authentication Successful"), message: Text("You have been successfully authenticated."), dismissButton: .default(Text("OK")) {
                    Avc.loggedIn()
                })
            }
        }
    }
}

#Preview {
    AuthenticateView()
}
