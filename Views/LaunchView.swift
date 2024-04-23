//
//  LaunchView.swift
//  GrappleGuide_v1.3
//
//  Created by connorsMac on 2024-02-27.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("GrappleGuideBkrnd")
                    .resizable()
                    .cornerRadius(20)
                    .ignoresSafeArea()
            
                VStack(alignment: .leading, spacing: 20) {
                    Spacer()
                    NavigationLink(destination: AuthenticateView()) {
                        HStack {
                            Spacer()
                            Text("LOGIN")
                                .font(.system(size: 50, weight: .heavy))
                                .foregroundColor(.white)
                                .padding(.bottom)
                            Spacer()
                        }
                    }
                    NavigationLink(destination: RegisterView()) {
                        HStack {
                            Spacer()
                            Text("SIGN UP")
                                .font(.system(size: 50, weight: .heavy))
                                .foregroundColor(.white)
                                .padding(.top)
                            Spacer()
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    LaunchView()
}
