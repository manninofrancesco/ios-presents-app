import Foundation

class UserService: ObservableObject {
    private var httpService = HttpService()
    
    func getCurrentUser() async throws -> UserModel {
        return UserModel(
            id: UUID(uuidString: "66003dbd-efa4-48fc-8590-2f671c43bdc3")!,
            username: "Bea",
            email: "setteuno.b@gmail.com")
    }
    
    func getAllUsers() async throws -> [UserModel] {
        let response = try await httpService.httpRequest(
            method: "GET",
            url: "/users",
            responseType: [UserModel].self)
        
        return response.data
    }
    
    func getByProp(propName: String, propValue: String) async throws -> UserModel {
        let response = try await httpService.httpRequest(
            method: "GET",
            url: "/user/getByProp/\(propName)/\(propValue)",
            responseType: UserModel.self)
        
        return response.data
    }
}
