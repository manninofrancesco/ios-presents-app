import SwiftUI

struct SearchView: View {
    private let userService = UserService()
    @State private var users: [UserModel] = []
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack{
            List (searchResults) { user in
                NavigationLink(destination: UserProfileView(userId: user.id)) {
                    Text(user.username)
                }
                
            }.refreshable {
                Task {
                    try await loadUsers()
                }
            }
            .navigationTitle("🔍 Cerca")
            .onAppear {
                Task {
                    try await loadUsers()
                }
            }
        }
        .contentMargins(20)
        .searchable(text: $searchText)
    }
    
    var searchResults: [UserModel] {
        if searchText.isEmpty {
            return self.users
        } else {
            return users.filter { $0.username.range(of: searchText, options: .caseInsensitive) != nil  }
        }
    }
    
    private func loadUsers() async throws{
        self.users = try await self.userService.getAllUsers()
    }
}

#Preview {
    SearchView()
}
