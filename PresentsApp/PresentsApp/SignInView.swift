import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var username: String = ""
    private var userService = UserService()
    private var authService = AuthService()
    @EnvironmentObject var loginStatus: LoginStatus
    
    var body: some View {
        NavigationStack {
            Form{
                Section{
                    TextField("Email", text: $email)
                    TextField("Password", text: $password)
                    TextField("Username", text: $username)
                }
            footer: {
                Button(){
                    Task {
                        try await signIn(email: email, password: password, username: username)
                    }
                }
            label: {
                Text("Registrati")
            }.buttonStyle(.borderedProminent)
                    .controlSize(.regular)
            }
            }.navigationTitle("🔒 Registrazione")
        }
    }
    
    private func signIn(email: String, password: String, username: String) async throws {
        
        let newUserData: UserModel = UserModel(id: UUID(), username: username, email: email, password: password)
        
        let userId = try await userService.create(userData: newUserData)
        
        let loginData: LoginData = LoginData(email: email, password: password)
        
        let authData: AuthData = try await self.authService.login(loginData: loginData)
        
        loginStatus.loggedUserId = userId.uuidString
        loginStatus.accessToken = authData.accessToken
        loginStatus.refreshToken = authData.refreshToken
        
    }
}

#Preview {
    ContentView()
}

