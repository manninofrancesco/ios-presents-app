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
                .tabItem { Label("Amici", systemImage: "magnifyingglass") }
            
            ProfileView()
                .tabItem { Label("Tu", systemImage: "person") }
        }
    }
}

struct PresentsView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Lista regali")
            }
            .padding()
            .navigationBarTitle("I tuoi regali")
        }
    }
}

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Il tuo profilo")
            }
            .padding()
            .navigationBarTitle("Tu")
        }
    }
}

struct FriendsView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Amici")
            }
            .padding()
            .navigationBarTitle("Amici")
        }
    }
}

#Preview {
    ContentView()
}
