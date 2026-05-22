import Foundation

struct SportDiscipline: Identifiable, Hashable {
    let id: UUID
    let name: String
    let subtitle: String
    let description: String
    let iconName: String
    let category: Category
    let difficulty: Difficulty
    let keyMuscles: [String]
    let coreSkills: [String]
    let scienceFact: String
    let isPremium: Bool
    let premiumPack: SubscriptionID?

    init(
        name: String,
        subtitle: String,
        description: String,
        iconName: String,
        category: Category,
        difficulty: Difficulty,
        keyMuscles: [String],
        coreSkills: [String],
        scienceFact: String,
        isPremium: Bool = false,
        premiumPack: SubscriptionID? = nil
    ) {
        self.id          = UUID()
        self.name        = name
        self.subtitle    = subtitle
        self.description = description
        self.iconName    = iconName
        self.category    = category
        self.difficulty  = difficulty
        self.keyMuscles  = keyMuscles
        self.coreSkills  = coreSkills
        self.scienceFact = scienceFact
        self.isPremium   = isPremium
        self.premiumPack = premiumPack
    }

    enum Category: String, CaseIterable {
        case trackField   = "Track & Field"
        case courtSports  = "Court Sports"
        case urban        = "Urban Athletics"
        case gymnastics   = "Gymnastics"
        case training     = "Training Systems"
        case conditioning = "Conditioning"
    }

    enum Difficulty: Int, Comparable, CaseIterable {
        case beginner     = 1
        case intermediate = 2
        case advanced     = 3
        case elite        = 4

        static func < (lhs: Difficulty, rhs: Difficulty) -> Bool {
            lhs.rawValue < rhs.rawValue
        }

        var label: String {
            switch self {
            case .beginner:     "Beginner"
            case .intermediate: "Intermediate"
            case .advanced:     "Advanced"
            case .elite:        "Elite"
            }
        }
    }
}
