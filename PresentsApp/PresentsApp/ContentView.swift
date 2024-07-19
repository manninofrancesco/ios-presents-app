//
//  ContentView.swift
//  Presents App
//
//  Created by Francesco on 17/05/24.
//

import SwiftUI

struct ContentView: View {
    private let userService = UserService()
    let loggedIn: Bool = false
    
    var body: some View {
        if(loggedIn){
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
        else{
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
