import Foundation

struct UserModel: Identifiable, Codable {
    let id: UUID
    let username: String
    let email: String
}
