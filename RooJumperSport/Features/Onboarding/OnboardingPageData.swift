import Foundation

enum OnboardingData {

    struct SportOption: Identifiable {
        let id: String
        let name: String
        let icon: String
        let color: String // "lime" | "orange" | "blue"
    }

    struct LevelOption: Identifiable {
        let id: String
        let name: String
        let description: String
        let icon: String
        let hint: String
    }

    struct EvolutionPreview {
        let name: String
        let icon: String
    }

    static let sports: [SportOption] = [
        SportOption(id: "basketball", name: "Basketball",    icon: "basketball.fill",        color: "orange"),
        SportOption(id: "volleyball", name: "Volleyball",    icon: "volleyball.fill",        color: "blue"),
        SportOption(id: "track",      name: "Track & Field", icon: "arrow.up.circle.fill",   color: "lime"),
        SportOption(id: "parkour",    name: "Parkour",       icon: "figure.run",             color: "orange"),
        SportOption(id: "gymnastics", name: "Gymnastics",    icon: "figure.gymnastics",      color: "blue"),
        SportOption(id: "general",    name: "General",       icon: "flame.fill",             color: "lime"),
    ]

    static let levels: [LevelOption] = [
        LevelOption(
            id: "beginner",
            name: "Beginner",
            description: "Starting my athletic training journey",
            icon: "figure.walk",
            hint: "0–12 months training experience"
        ),
        LevelOption(
            id: "intermediate",
            name: "Intermediate",
            description: "Actively training for over a year",
            icon: "bolt.fill",
            hint: "1–3 years, understands fundamentals"
        ),
        LevelOption(
            id: "advanced",
            name: "Advanced",
            description: "Competitive athlete, serious background",
            icon: "flame.fill",
            hint: "3+ years, competition experience"
        ),
    ]

    static let evolutionPreviews: [EvolutionPreview] = [
        EvolutionPreview(name: "Ground Zero",         icon: "figure.walk"),
        EvolutionPreview(name: "Jump Apprentice",     icon: "figure.run"),
        EvolutionPreview(name: "Explosive Cadet",     icon: "bolt.fill"),
        EvolutionPreview(name: "Athletic Specialist", icon: "figure.gymnastics"),
        EvolutionPreview(name: "Elite Performer",     icon: "star.fill"),
    ]
}
