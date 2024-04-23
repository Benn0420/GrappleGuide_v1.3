//
//  GrappleGuide_v1_3App.swift
//  GrappleGuide_v1.3
//
//  Created by connorsMac on 2024-02-27.
//

import SwiftUI
import Firebase

@main
struct GrappleGuide_v1_3App: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LaunchView()
        }
    }
}
