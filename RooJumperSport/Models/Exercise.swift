import Foundation

struct Exercise: Identifiable, Hashable {
    let id: UUID
    let name: String
    let category: Category
    let description: String
    let sets: Int
    let repsDisplay: String
    let restSeconds: Int
    let durationSeconds: Int?
    let muscleGroups: [String]
    let coachingCues: [String]
    let difficulty: SportDiscipline.Difficulty
    let isPremium: Bool
    let premiumPack: SubscriptionID?
    let xpReward: Int

    init(
        name: String,
        category: Category,
        description: String,
        sets: Int,
        repsDisplay: String,
        restSeconds: Int,
        durationSeconds: Int? = nil,
        muscleGroups: [String],
        coachingCues: [String],
        difficulty: SportDiscipline.Difficulty,
        isPremium: Bool = false,
        premiumPack: SubscriptionID? = nil,
        xpReward: Int = 50
    ) {
        self.id              = UUID()
        self.name            = name
        self.category        = category
        self.description     = description
        self.sets            = sets
        self.repsDisplay     = repsDisplay
        self.restSeconds     = restSeconds
        self.durationSeconds = durationSeconds
        self.muscleGroups    = muscleGroups
        self.coachingCues    = coachingCues
        self.difficulty      = difficulty
        self.isPremium       = isPremium
        self.premiumPack     = premiumPack
        self.xpReward        = xpReward
    }

    enum Category: String, CaseIterable {
        case plyometric   = "Plyometric"
        case strength     = "Strength"
        case mobility     = "Mobility"
        case coordination = "Coordination"
        case reaction     = "Reaction"
        case recovery     = "Recovery"
        case technique    = "Technique"

        var iconName: String {
            switch self {
            case .plyometric:   "bolt.fill"
            case .strength:     "dumbbell.fill"
            case .mobility:     "figure.flexibility"
            case .coordination: "figure.mixed.cardio"
            case .reaction:     "timer"
            case .recovery:     "heart.fill"
            case .technique:    "checkmark.seal.fill"
            }
        }
    }
}
