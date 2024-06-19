//
//  FriendsView.swift
//  PresentsApp
//
//  Created by Francesco on 01/06/24.
//

import SwiftUI

struct FriendsView: View {
    private let userService = UserService()
    @State private var users: [UserModel] = []
    
    var body: some View {
        NavigationStack{
            List (self.users) { user in
                NavigationLink(destination: PresentsView(userId: user.id)) {
                    Text(user.username)
                }
                
            }.refreshable {
                Task {
                    try await loadUsers()
                }
            }
            .navigationTitle("🫂 Amici")
            .onAppear {
                Task {
                    try await loadUsers()
                }
            }
        }
        .contentMargins(20)
    }
    
    private func loadUsers() async throws{
        self.users = try await self.userService.getAllUsers()
    }
}

#Preview {
    FriendsView()
}
