import Foundation

class UserService: ObservableObject {
    private var httpService = HttpService()
    
    func getCurrentUser() async throws -> UserModel {
        return UserModel(
            id: UUID(uuidString: "ca7d357e-c6c8-4b85-86b7-49eb492b3899")!,
            username: "Fra",
            email: "francesco.mannino1999@gmail.com")
    }
    
    func getAllUsers() async throws -> [UserModel] {
        let response = try await httpService.httpRequest(method: "GET", url: "/users", responseType: [UserModel].self)
        
        return response.data
    }
}
