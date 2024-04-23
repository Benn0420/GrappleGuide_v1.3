//
//  ProfileView.swift
//  GrappleGuide_v1.3
//
//  Created by connorsMac on 2024-03-05.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var Pvc = profileViewController()
    
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
                    VStack {
                        HStack {
                            Spacer()
                            if let image = Pvc.profileImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150)
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            }
                            Spacer()
                        }
                        Text(Pvc.username)
                            .font(.system(size: 30))
                            .foregroundColor(Pvc.backgroundColor)
                            .colorInvert()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(10)
                        Text(Pvc.email)
                            .font(.system(size: 20))
                            .foregroundColor(Pvc.backgroundColor)
                            .colorInvert()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.leading, 10)
                        Text(Pvc.birthDate)
                            .font(.system(size: 20))
                            .foregroundColor(Pvc.backgroundColor)
                            .colorInvert()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.leading, 10)
                        HStack {
                            Spacer()
                            Text("To give less than your best is a sacrifice of the gift.")
                                .font(.system(size: 20))
                                .foregroundColor(Pvc.backgroundColor)
                                .colorInvert()
                                .italic()
                                .multilineTextAlignment(.center)
                                .padding()
                            Spacer()
                        }
                        .padding(20)
                        Text("\(Pvc.trainingAge) YEARS")
                            .font(.system(size: 50, weight: .heavy))
                            .foregroundColor(Pvc.backgroundColor)
                            .colorInvert()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(10)
                    }
                    .frame(width: framewidth, height: frameheight)
                    .background(Pvc.backgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding(.horizontal, 0.05 * geometry.size.width)
                    .padding(.vertical, 100)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
