import Foundation

struct PresentModel: Identifiable, Codable {
    let id: UUID
    var title: String
    var description: String?
    let userId: UUID?
    
    init(){
        id = UUID()
        title = ""
        description = ""
        userId = nil
    }
    
    init(id: UUID, title: String, description: String?, userId: UUID) {
        self.id = id
        self.title = title
        self.description = description
        self.userId = userId
    }
}
