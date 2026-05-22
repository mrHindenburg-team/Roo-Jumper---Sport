import Foundation
import SwiftData

@Model
final class TrainingSessionRecord {
    var sessionID: UUID
    var date: Date
    var disciplineName: String
    var exercisesCompleted: Int
    var durationMinutes: Int
    var xpEarned: Int

    init(disciplineName: String, exercisesCompleted: Int, durationMinutes: Int, xpEarned: Int) {
        self.sessionID          = UUID()
        self.date               = Date.now
        self.disciplineName     = disciplineName
        self.exercisesCompleted = exercisesCompleted
        self.durationMinutes    = durationMinutes
        self.xpEarned           = xpEarned
    }
}
