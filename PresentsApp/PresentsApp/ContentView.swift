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

// Define the data model for a present
struct Present: Identifiable {
    var id = UUID()
    var name: String
}

struct PresentsView: View {
    let presents: [Present] = [
            Present(name: "Regalo 1"),
            Present(name: "Regalo 2"),
            Present(name: "Regalo 3"),
            Present(name: "Regalo 4"),
            Present(name: "Regalo 5")
        ]
    
    var body: some View {
        NavigationView {
            List(presents) { present in
                Text(present.name)
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
