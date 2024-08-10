import SwiftUI

struct MyProfileView: View {
    @State var currentUser: UserModel? = nil
    var userService: UserService = UserService()
    var authService: AuthService = AuthService()
    @State var loading: Bool = true
    @EnvironmentObject var loginStatus: LoginStatus
    
    var body: some View {
        NavigationView {
            VStack {
                if(!loading && currentUser != nil){
                    Text(currentUser!.username)
                    Text(currentUser!.email)
                }
                Button(){
                    Task {
                        try await self.deleteCurrentUser()
                    }
                }
                label: {
                    Text("❌ Elimina account")
                }
                Button(){
                    Task {
                        try await self.logout()
                    }
                }
                label: {
                    Text("Esci")
                }
            }
            .padding()
            .navigationBarTitle("🫵🏼 Profilo")
            .onAppear{
                Task {
                    currentUser = try await userService.getByProp(propName: "id", propValue: loginStatus.loggedUserId!)
                    self.loading = false
                }
            }
        }
    }
    private func logout() async throws {
        loginStatus.loggedUserId = nil
    }
    
    private func deleteCurrentUser() async throws {
        try await userService.delete(userId: UUID(uuidString: loginStatus.loggedUserId!)!)
        try await self.logout()
    }
}
