import Foundation
import SwiftData

@Observable
@MainActor
final class ProgressionService {

    // MARK: - State

    private(set) var userProgress: UserProgress
    private(set) var achievements: [Achievement]
    private(set) var recentlyUnlocked: Achievement?
    private(set) var metrics: [JumpMetric]

    // MARK: - Init

    init(progress: UserProgress) {
        self.userProgress = progress
        self.achievements = TrainingDataStore.achievements
        self.metrics = TrainingDataStore.sampleMetrics
        syncAchievements()
    }

    // MARK: - XP & Leveling

    func awardXP(_ amount: Int, context: ModelContext) {
        userProgress.totalXP += amount
        let xpPerLevel = 500
        let newLevel = max(1, userProgress.totalXP / xpPerLevel + 1)
        if newLevel > userProgress.currentLevel {
            userProgress.currentLevel = newLevel
        }
        saveProgress(context: context)
    }

    // MARK: - Training Completion

    func completeWorkout(
        disciplineName: String,
        exercisesCompleted: Int,
        durationMinutes: Int,
        xpEarned: Int,
        context: ModelContext
    ) {
        userProgress.totalWorkoutsCompleted += 1
        updateStreak(context: context)
        awardXP(xpEarned, context: context)
        let session = TrainingSessionRecord(
            disciplineName: disciplineName,
            exercisesCompleted: exercisesCompleted,
            durationMinutes: durationMinutes,
            xpEarned: xpEarned
        )
        context.insert(session)
        syncAchievements()
        checkForNewUnlocks()
        saveProgress(context: context)
    }

    // MARK: - Evolution Stage

    var currentEvolutionStage: TrainingDataStore.EvolutionStage {
        let xp = userProgress.totalXP
        let stage = TrainingDataStore.evolutionStages.last(where: { xp >= $0.xpRequired })
        return stage ?? TrainingDataStore.evolutionStages[0]
    }

    var nextEvolutionStage: TrainingDataStore.EvolutionStage? {
        let current = currentEvolutionStage
        let next = current.index + 1
        return TrainingDataStore.evolutionStages.first(where: { $0.index == next })
    }

    var evolutionProgress: Double {
        guard let next = nextEvolutionStage else { return 1.0 }
        let current = currentEvolutionStage
        let earned = userProgress.totalXP - current.xpRequired
        let needed = next.xpRequired - current.xpRequired
        return Double(earned) / Double(needed)
    }

    // MARK: - AI Session Management

    var canUseAI: Bool {
        userProgress.aiMessagesUsedThisSession < AppConstants.aiFreeTierLimit
    }

    var aiMessagesRemaining: Int {
        max(0, AppConstants.aiFreeTierLimit - userProgress.aiMessagesUsedThisSession)
    }

    func recordAIMessage(context: ModelContext) {
        userProgress.aiMessagesUsedThisSession += 1
        saveProgress(context: context)
    }

    func resetAISession(context: ModelContext) {
        userProgress.aiMessagesUsedThisSession = 0
        userProgress.sessionStartDate = Date.now
        saveProgress(context: context)
    }

    // MARK: - Metrics

    func addMetric(_ metric: JumpMetric) {
        metrics.insert(metric, at: 0)
        if metrics.count > 50 {
            metrics = Array(metrics.prefix(50))
        }
    }

    func latestValue(for type: JumpMetric.MetricType) -> Double? {
        metrics.first(where: { $0.type == type })?.value
    }

    // MARK: - Private

    private func updateStreak(context: ModelContext) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date.now)
        let lastActive = calendar.startOfDay(for: userProgress.lastActiveDate)
        let daysDiff = calendar.dateComponents([.day], from: lastActive, to: today).day ?? 0

        if daysDiff == 1 {
            userProgress.currentStreak += 1
        } else if daysDiff > 1 {
            userProgress.currentStreak = 1
        }
        userProgress.longestStreak = max(userProgress.longestStreak, userProgress.currentStreak)
        userProgress.lastActiveDate = Date.now
        saveProgress(context: context)
    }

    private func syncAchievements() {
        for i in achievements.indices {
            switch achievements[i].name {
            case "First Jump":
                if userProgress.totalWorkoutsCompleted >= 1 { unlock(at: i) }
            case "On Fire":
                if userProgress.currentStreak >= 3 { unlock(at: i) }
            case "Weekly Warrior":
                if userProgress.currentStreak >= 5 { unlock(at: i) }
            case "Elite Initiator":
                if userProgress.currentLevel >= 5 { unlock(at: i) }
            case "Unstoppable":
                if userProgress.currentStreak >= 14 { unlock(at: i) }
            case "Evolution Stage 2":
                if currentEvolutionStage.index >= 1 { unlock(at: i) }
            case "Evolution Stage 4":
                if currentEvolutionStage.index >= 3 { unlock(at: i) }
            default:
                break
            }
        }
    }

    private func unlock(at index: Int) {
        guard !achievements[index].isUnlocked else { return }
        achievements[index].isUnlocked = true
        achievements[index].unlockedDate = Date.now
        recentlyUnlocked = achievements[index]
        Task {
            try? await Task.sleep(for: .seconds(4))
            recentlyUnlocked = nil
        }
    }

    private func checkForNewUnlocks() {
        syncAchievements()
    }

    private func saveProgress(context: ModelContext) {
        try? context.save()
    }
}
