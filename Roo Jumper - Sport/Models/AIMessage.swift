import Foundation

struct AIMessage: Identifiable, Equatable {
    let id: UUID
    var content: String
    let role: Role
    let timestamp: Date
    var isFromFallback: Bool

    init(content: String, role: Role, isFromFallback: Bool = false) {
        self.id            = UUID()
        self.content       = content
        self.role          = role
        self.timestamp     = Date.now
        self.isFromFallback = isFromFallback
    }

    enum Role {
        case user
        case coach
    }
}
