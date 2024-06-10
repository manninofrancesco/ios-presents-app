//
//  UserModel.swift
//  PresentsApp
//
//  Created by Francesco on 10/06/24.
//

import Foundation

struct UserModel: Identifiable, Codable {
    var id: UUID = UUID()
    var username: String = ""
    var email: String? = nil
}
