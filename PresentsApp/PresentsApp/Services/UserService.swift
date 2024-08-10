import Foundation

class UserService: ObservableObject {
    private var httpService = HttpService()
    private let defaults = UserDefaults.standard
    
    func getCurrentUser() async throws -> UserModel? {
        let storedCurrentUserId: String? = defaults.string(forKey: "loggedUserId")
        if(storedCurrentUserId != nil){
            let response: UserModel = try await self.getByProp(propName: "id", propValue: storedCurrentUserId!)
            return response
        }
        
        return nil
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
    
    func create(userData: UserModel) async throws -> UUID {
        
        let body = try JSONEncoder().encode(userData)
        
        let response = try await httpService.httpRequest(
            method: "POST",
            url: "/user/create",
            responseType: UUID.self,
            body: body)
        
        return response.data
    }
    
    func delete(userId: UUID) async throws {
        
        let _ = try await httpService.httpRequest(
            method: "DELETE",
            url: "/user/delete/\(userId)",
            responseType: UUID.self)
    }
}
