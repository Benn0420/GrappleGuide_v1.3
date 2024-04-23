//
//  RegisterView.swift
//  GrappleGuide_v1.3
//
//  Created by connorsMac on 2024-02-27.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var Rvc = registerViewController()
    
    var body: some View {
        GeometryReader { geometry in
            let framewidth = geometry.size.width * 0.9
            let frameheight = geometry.size.height * 0.8
            
            ZStack {
                Image("GrappleGuideBkrnd")
                    .resizable()
                    .cornerRadius(20)
                    .ignoresSafeArea()
                VStack {
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack(alignment: .leading, spacing: 5) {
                            TextField("Real name", text: $Rvc.realname)
                                .textFieldStyle(.roundedBorder)
                                .textInputAutocapitalization(.never)
                                .colorInvert()
                                .padding()
                            TextField("Username", text: $Rvc.username)
                                .textFieldStyle(.roundedBorder)
                                .textInputAutocapitalization(.never)
                                .colorInvert()
                                .padding()
                            SecureField("Password", text: $Rvc.password)
                                .textFieldStyle(.roundedBorder)
                                .textInputAutocapitalization(.never)
                                .colorInvert()
                                .privacySensitive()
                                .padding()
                            DatePicker(" Birth Date: ",
                                       selection: $Rvc.birthDate,
                                       in: Rvc.minDate...Rvc.maxDate,
                                       displayedComponents: [.date])
                            .datePickerStyle(.compact)
                            .tint(.white)
                            .padding()
                            ColorPicker("Favourite color: ", selection: $Rvc.backgroundColor, supportsOpacity: true)
                                .foregroundStyle(Color.white)
                                .padding()
                            TextField("Email", text: $Rvc.email)
                                .textFieldStyle(.roundedBorder)
                                .textInputAutocapitalization(.never)
                                .colorInvert()
                                .padding()
                            TextField("Years of Experience", text: $Rvc.trainingAge)
                                .textFieldStyle(.roundedBorder)
                                .textInputAutocapitalization(.never)
                                .colorInvert()
                                .padding()
                            Button("Select Profile Photo") {
                                Rvc.profilePictureView = true
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            
                        }
                        .padding(.top, 40)
                        .sheet(isPresented: $Rvc.profilePictureView, content: {
                            ImagePicker(isPresented: $Rvc.profilePictureView, image: $Rvc.profileImage)
                        })
                        HStack {
                            Spacer()
                            Button("CONFIRM INFO", action: Rvc.confirmSelected)
                                .tint(.white)
                                .font(.system(size: 40, weight: .heavy))
                            Spacer()
                        }
                        .padding(.top, 20)
                    }
                }
                .frame(width: framewidth, height: frameheight, alignment: .center)
            }
            .fullScreenCover(isPresented: $Rvc.presentCreateProfileView) {
                CreateProfileView(Rvc: Rvc, dismissHandler: Rvc.dismissCreateProfileView)
            }
            .navigationDestination(isPresented: $Rvc.profileCreated) {
                AuthenticateView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    RegisterView()
}
