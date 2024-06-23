//
//  ContentView.swift
//  Presents App
//
//  Created by Francesco on 17/05/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PresentsView()
                .tabItem { Label("Regali", systemImage: "house") }
            FriendsView()
                .tabItem { Label("Amici", systemImage: "person.2.fill") }
            SearchView()
                .tabItem { Label("Cerca", systemImage: "magnifyingglass") }
            MyProfileView()
                .tabItem { Label("Tu", systemImage: "person") }
        }
    }
}

#Preview {
    ContentView()
}
