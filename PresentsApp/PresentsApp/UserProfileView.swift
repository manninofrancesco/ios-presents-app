import Foundation
import SwiftUI

struct UserProfileView: View {
    let userId: UUID?
    @StateObject private var userService = UserService()
    @StateObject private var presentService = PresentService()
    @State private var user: UserModel?
    @State private var userPresents: [PresentModel]?
    @State private var loading: Bool = true

    var body: some View {
        NavigationStack {
            VStack {
                if(!loading){
                    if(userPresents != nil){
                        Text("Ecco qualche idea 😁")
                        List (userPresents!) { present in
                            NavigationLink(present.title, destination: PresentView(presentId: present.id))
                        }.refreshable {
                            Task {
                                try await loadUserPresents(userId: userId)
                            }
                        }
                    }else{
                        Text("La sua whishlist è vuota 🥲")
                    }
                }
            }
            .padding()
            .navigationBarTitle(user?.username ?? "")
            .onAppear {
                Task {
                    try await loadUser(userId: userId)
                    try await loadUserPresents(userId: userId)
                    self.loading = false
                }
            }
        }
    }

    private func loadUser(userId: UUID?) async throws {
        guard let userId = userId else { return }
        user = try await userService.getByProp(propName: "id", propValue: userId.uuidString)
    }
    
    
    private func loadUserPresents(userId: UUID?) async throws {
        userPresents = try await presentService.getUserPresents(inputUserId: userId)
    }
}

#Preview {
    UserProfileView(userId: UUID())
}
