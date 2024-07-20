import Foundation

class AuthService: ObservableObject {
    private var httpService = HttpService()
    
    func login(loginData: LoginData) async throws -> AuthData {
        let body = try JSONEncoder().encode(loginData)
        
        let response = try await httpService.httpRequest(
            method: "POST",
            url: "/auth/login",
            responseType: AuthData.self,
            body: body)
        
        return response.data
    }
}
