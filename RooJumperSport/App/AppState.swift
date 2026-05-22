import SwiftUI
import SwiftData

@Observable
@MainActor
final class AppState {

    // MARK: - Navigation

    var showSplash = true

    var hasSeenOnboarding: Bool {
        didSet { UserDefaults.standard.set(hasSeenOnboarding, forKey: "roo.hasSeenOnboarding") }
    }

    // MARK: - Services

    let aiCoach = AICoachService()
    var progression: ProgressionService

    // MARK: - Init

    init(progress: UserProgress) {
        hasSeenOnboarding = UserDefaults.standard.bool(forKey: "roo.hasSeenOnboarding")
        progression = ProgressionService(progress: progress)
    }
}
