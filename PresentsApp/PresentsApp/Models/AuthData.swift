import Foundation

struct AuthData: Codable {
    let accessToken: String
    let refreshToken: String
    let userId: UUID
}
