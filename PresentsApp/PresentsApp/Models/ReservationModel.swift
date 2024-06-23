import Foundation

struct ReservationModel: Identifiable, Codable {
    let id: UUID
    let presentId: UUID
    let reserverUserId: UUID
}

