import Foundation

struct PresentModel: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String?
    let link: String?
    let userId: UUID
}
