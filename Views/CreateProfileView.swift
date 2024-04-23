//
//  CreateProfileView.swift
//  GrappleGuide_v1.3
//
//  Created by connorsMac on 2024-02-27.
//

import SwiftUI

struct CreateProfileView: View {
    @StateObject var Rvc: registerViewController
    var dismissHandler: (() -> Void)? = nil
    
    var body: some View {
        GeometryReader { geometry in
            let framewidth = geometry.size.width * 0.9
            let frameheight = geometry.size.height * 0.7

            ZStack {
                Image("GrappleGuideBkrnd")
                    .resizable()
                    .cornerRadius(20)
                    .ignoresSafeArea()
                
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                    Spacer(minLength: 100)
                    VStack {
                        HStack {
                            Spacer()
                            if let image = Rvc.profileImage {
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
                        .padding(20)
                        Text("@\(Rvc.username)")
                            .font(.system(size: 30))
                            .foregroundColor(Rvc.backgroundColor)
                            .colorInvert()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(10)
                        Text("\(Rvc.email)")
                            .font(.system(size: 20))
                            .foregroundColor(Rvc.backgroundColor)
                            .colorInvert()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(10)
                        HStack {
                            Spacer()
                            Text("To give less than your best is a sacrifice of the gift.")
                                .font(.system(size: 14))
                                .italic()
                                .foregroundColor(Rvc.backgroundColor)
                                .colorInvert()
                                .multilineTextAlignment(.center)
                                .padding()
                            Spacer()
                        }
                        .padding(20)
                        Text("\(Rvc.trainingAge) YEARS")
                            .font(.system(size: 50, weight: .heavy))
                            .foregroundColor(Rvc.backgroundColor)
                            .colorInvert()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(10)
                        Spacer()
                    }
                    .frame(width: framewidth, height: frameheight)
                    .background(Rvc.backgroundColor)
                    .cornerRadius(30)
                    Spacer()
                    
                    VStack {
                        Button(action: {
                            Rvc.create()
                            dismissHandler?()
                        }) {
                            Text("OSS")
                        }
                            .tint(.white)
                            .font(.system(size: 50, weight: .heavy))
                    }
                    .padding(.bottom, 20)
                }
            }
        }
    }
}

struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView(Rvc: registerViewController())
    }
}
