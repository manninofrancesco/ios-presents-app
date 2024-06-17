import Foundation
import Combine

class PresentService: ObservableObject {
    @Published var presents: [PresentModel] = []
    private let loggedUserId = "ca7d357e-c6c8-4b85-86b7-49eb492b3899"
    private var httpService = HttpService()
    
    func getUserPresents() async throws {
        let response = try await httpService.httpRequest(
            method: "GET",
            url: "/user/\(loggedUserId)/presents",
            responseType: [PresentModel].self)
        
        await MainActor.run {
            self.presents = response.data
        }
    }
    
    func addPresent(model: PresentModel) async throws
    {
        let _: BaseHttpResponse<UUID> = try await httpService.httpRequest(
            method: "POST",
            url: "/present/create", 
            body: model,
            responseType: UUID.self)
    }
    
    func deletePresent(id: UUID) async throws
    {
        let _: BaseHttpResponse = try await httpService.httpRequest(
            method: "DELETE",
            url: "/present/delete/\(id)",
            responseType: UUID.self)
    }
    
}
