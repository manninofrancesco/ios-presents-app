import Foundation
import Combine

class PresentService: ObservableObject {
    private var httpService = HttpService()
    private var userService = UserService()
    
    func getUserPresents(inputUserId: Optional<UUID>)
    async throws  -> [PresentModel] {
        var userId: UUID = UUID()
        if(inputUserId != nil){
            userId = inputUserId!
        }else{
            let currentUser = try await userService.getCurrentUser()
            if(currentUser != nil){
                userId = currentUser!.id
            }else{
                throw GenericError.userNotFound
            }
        }
        
        let response = try await httpService.httpRequest(
            method: "GET",
            url: "/user/\(userId)/presents",
            responseType: [PresentModel].self)
        
        
        return response.data
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
    
    func updatePresent(model: PresentModel) async throws
    {
        let body = try JSONEncoder().encode(model)
        
        let _: BaseHttpResponse<UUID> = try await httpService.httpRequest(
            method: "PUT",
            url: "/present/update",
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
    
    func getPresent(id: UUID) async throws -> PresentModel
    {
        let response: BaseHttpResponse = try await httpService.httpRequest(
            method: "GET",
            url: "/present/getById/\(id)",
            responseType: PresentModel.self)
        
        return response.data
    }
    
    func bookPresent(presentID: UUID) async throws -> ReservationModel {
        let accessToken = UserDefaults.standard.string(forKey: "accessToken")
        let response: BaseHttpResponse<ReservationModel> = try await httpService.httpRequest(
            method: "PUT",
            url: "/present/\(presentID)/book",
            responseType: ReservationModel.self,
            authToken: accessToken)
        
        return response.data
    }
    
    func getPresentReservation(presentID: UUID) async throws -> ReservationModel? {
        let response : BaseHttpResponse<ReservationModel?> = try await httpService.httpRequest(
            method: "GET",
            url: "/present/\(presentID)/reservation",
            responseType: ReservationModel?.self
        )
        
        return response.data
    }
    
    func undoReservation(presentID: UUID) async throws -> Bool {
        let accessToken = UserDefaults.standard.string(forKey: "accessToken")
        let response : BaseHttpResponse<Bool> = try await httpService.httpRequest(
            method: "DELETE",
            url: "/present/\(presentID)/undoReservation",
            responseType: Bool.self,
            authToken: accessToken
        )
        
        return response.data
    }
    
}
