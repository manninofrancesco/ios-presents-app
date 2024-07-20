import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    private var authService = AuthService()
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var loginStatus: LoginStatus
    
    var body: some View {
        NavigationStack {
            Form{
                Section{
                    TextField("Email", text: $email)
                    TextField("Password", text: $password)
                }
            footer: {
                Button(){
                    Task {
                        try await login(email: email, password: password)
                    }
                }
            label: {
                Text("Login")
            }.buttonStyle(.borderedProminent)
                    .controlSize(.regular)
            }
            }.navigationTitle("🔒 Login")
        }
    }
    
    private func login(email: String, password: String) async throws {
        
        let loginData: LoginData = LoginData(email: email, password: password)
        
        let authData: AuthData = try await self.authService.login(loginData: loginData)
        
        loginStatus.loggedUserId = authData.userId.uuidString
        loginStatus.accessToken = authData.accessToken
        loginStatus.refreshToken = authData.refreshToken
    }
}
