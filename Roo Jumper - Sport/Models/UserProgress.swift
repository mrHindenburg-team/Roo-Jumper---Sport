import Foundation
import SwiftData

@Model
final class UserProgress {
    var totalXP: Int
    var currentLevel: Int
    var currentStreak: Int
    var longestStreak: Int
    var totalWorkoutsCompleted: Int
    var evolutionStage: Int
    var unlockedDisciplineIDs: [String]
    var completedExerciseIDs: [String]
    var lastActiveDate: Date
    var aiMessagesUsedThisSession: Int
    var sessionStartDate: Date
    var hasSeenAIDisclaimer: Bool

    init() {
        totalXP                   = 0
        currentLevel              = 1
        currentStreak             = 0
        longestStreak             = 0
        totalWorkoutsCompleted    = 0
        evolutionStage            = 0
        unlockedDisciplineIDs     = []
        completedExerciseIDs      = []
        lastActiveDate            = Date.now
        aiMessagesUsedThisSession = 0
        sessionStartDate          = Date.now
        hasSeenAIDisclaimer       = false
    }

    var levelTitle: String {
        switch currentLevel {
        case 1:    "Rookie Jumper"
        case 2:    "Athletic Initiator"
        case 3:    "Jump Apprentice"
        case 4:    "Explosiveness Seeker"
        case 5:    "Air Control Cadet"
        case 6:    "Dynamic Athlete"
        case 7:    "Jump Specialist"
        case 8:    "Plyometric Expert"
        case 9:    "Elite Performer"
        case 10...: "Jump Master"
        default:   "Rookie Jumper"
        }
    }

    var xpForNextLevel: Int { currentLevel * 500 }
    var progressToNextLevel: Double {
        let xpInCurrentLevel = totalXP - ((currentLevel - 1) * 500)
        return min(1.0, Double(xpInCurrentLevel) / Double(xpForNextLevel))
    }
}
