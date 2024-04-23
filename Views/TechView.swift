//
//  TechView.swift
//  GrappleGuide_v1.3
//
//  Created by connorsMac on 2024-04-18.
//

import SwiftUI

struct TechView: View {
    var dismissHandler: (() -> Void)? = nil
    var techName: String
    var techDescription: String
    
    var body: some View {
        VStack {
            Text("Choice: \(techName)")
                .font(.title)
                .foregroundStyle(Color.white)
                .multilineTextAlignment(.center)
                .padding(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.brown, lineWidth: 2))
            Text("Description: \(techDescription)")
                .font(.body)
                .foregroundStyle(Color.white)
                .multilineTextAlignment(.center)
                .padding(20)
            Button("EXIT") {
                dismissHandler?()
            }
            .foregroundColor(.red)
            .padding(20)
        }
        .padding(40)
        .background(.black)
    }
}

#Preview {
    TechView(techName: "Technique", techDescription: "Description")
}
