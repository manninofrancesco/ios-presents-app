//
//  UserService.swift
//  PresentsApp
//
//  Created by Francesco on 10/06/24.
//

import Foundation

class UserService: ObservableObject {
    private let baseUrl: String = "https://presents-app-production.up.railway.app"
    
    func getCurrentUser() async throws -> UserModel {
        return UserModel(
            id: UUID(uuidString: "ca7d357e-c6c8-4b85-86b7-49eb492b3899")!,
            username: "Fra",
            email: "francesco.mannino1999@gmail.com")
    }
    
    func getAllUsers() async throws -> [UserModel] {
        guard let url = URL(string: "\(baseUrl)/users") else {
            print("Invalid URL")
            return []
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(BaseHttpResponse<UserModel>.self, from: data)
        
        return decoded.data
    }
}
