//
//  MainScreenView.swift
//  GrappleGuide_v1.3
//
//  Created by connorsMac on 2024-03-05.
//

import SwiftUI

struct MainScreenView: View {
    var body: some View {
        TabView {
            Group {
                HomepageView()
                    .tag(0)
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                JournalView()
                    .tag(1)
                    .tabItem {
                        Label("Journal", systemImage: "book.fill")
                    }
                ProfileView()
                    .tag(2)
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
            }
            .toolbarBackground(Color.white, for: .tabBar)
        }
        .tint(Color.white)
    }
}


#Preview {
    MainScreenView()
}
