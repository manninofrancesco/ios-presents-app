//
//  UserService.swift
//  PresentsApp
//
//  Created by Francesco on 10/06/24.
//

import Foundation

class UserService: ObservableObject {
    func getCurrentUser() async throws -> UserModel {
        return UserModel(
            id: UUID(uuidString: "ca7d357e-c6c8-4b85-86b7-49eb492b3899")!,
            username: "Fra",
            email: "francesco.mannino1999@gmail.com")
    }
}
