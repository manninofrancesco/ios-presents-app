import Foundation
import Combine

class PresentService: ObservableObject {
    @Published var presents: [PresentModel] = []
    private var httpService = HttpService()
    private var userService = UserService()
    
    func getUserPresents(inputUserId: Optional<UUID>)
    async throws {
        var userId: UUID = UUID()
        if(inputUserId != nil){
            userId = inputUserId!
        }else{
            userId = try await userService.getCurrentUser().id
        }
        
        print("Getting user presents for: \(String(describing: userId))")
        
        let response = try await httpService.httpRequest(
            method: "GET",
            url: "/user/\(userId)/presents",
            responseType: [PresentModel].self)
        
        
        await MainActor.run {
            self.presents = response.data
        }
    }
    
    func addPresent(model: PresentModel) async throws
    {
        let body = try JSONEncoder().encode(model)
        
        let _: BaseHttpResponse<UUID> = try await httpService.httpRequest(
            method: "POST",
            url: "/present/create",
            responseType: UUID.self,
            body: body)
    }
    
    func deletePresent(id: UUID) async throws
    {
        let _: BaseHttpResponse = try await httpService.httpRequest(
            method: "DELETE",
            url: "/present/delete/\(id)",
            responseType: UUID.self)
    }
    
}
