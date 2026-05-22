import Foundation

struct Achievement: Identifiable, Hashable {
    let id: UUID
    let name: String
    let description: String
    let iconName: String
    let category: Category
    let xpReward: Int
    var isUnlocked: Bool
    var unlockedDate: Date?

    init(
        name: String,
        description: String,
        iconName: String,
        category: Category,
        xpReward: Int
    ) {
        self.id          = UUID()
        self.name        = name
        self.description = description
        self.iconName    = iconName
        self.category    = category
        self.xpReward    = xpReward
        self.isUnlocked  = false
        self.unlockedDate = nil
    }

    enum Category: String, CaseIterable {
        case milestone    = "Milestone"
        case consistency  = "Consistency"
        case mastery      = "Mastery"
        case exploration  = "Exploration"
        case challenge    = "Challenge"
        case aiCoach      = "AI Coach"

        var iconName: String {
            switch self {
            case .milestone:   "flag.fill"
            case .consistency: "flame.fill"
            case .mastery:     "star.fill"
            case .exploration: "map.fill"
            case .challenge:   "bolt.fill"
            case .aiCoach:     "brain.head.profile"
            }
        }
    }
}
