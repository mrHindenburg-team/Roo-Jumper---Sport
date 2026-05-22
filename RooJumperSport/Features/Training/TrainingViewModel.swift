import SwiftUI
import SwiftData

@Observable
@MainActor
final class TrainingViewModel {

    // MARK: - State

    var selectedCategory: Exercise.Category? = nil
    var selectedExercise: Exercise? = nil
    var completedExerciseIDs: Set<UUID> = []
    var sessionActive = false
    var sessionStartTime: Date = Date.now
    var showCompletionBanner = false
    var currentDiscipline: SportDiscipline? = nil

    // MARK: - Data

    var disciplines: [SportDiscipline] = TrainingDataStore.disciplines

    var filteredExercises: [Exercise] {
        let all = TrainingDataStore.exercises
        guard let category = selectedCategory else { return all }
        return all.filter { $0.category == category }
    }

    var sessionExercises: [Exercise] {
        guard currentDiscipline != nil else {
            return Array(TrainingDataStore.exercises.prefix(6))
        }
        let disciplineExercises = TrainingDataStore.exercises.filter { !$0.isPremium }
        return Array(disciplineExercises.prefix(6))
    }

    var sessionDurationSeconds: Int {
        guard sessionActive else { return 0 }
        return Int(Date.now.timeIntervalSince(sessionStartTime))
    }

    var sessionXPEarned: Int {
        completedExerciseIDs.reduce(0) { total, id in
            let xp = TrainingDataStore.exercises.first(where: { $0.id == id })?.xpReward ?? 0
            return total + xp
        }
    }

    // MARK: - Actions

    func startSession(discipline: SportDiscipline?) {
        currentDiscipline = discipline
        completedExerciseIDs.removeAll()
        sessionActive = true
        sessionStartTime = Date.now
    }

    func toggleExercise(_ exercise: Exercise) {
        if completedExerciseIDs.contains(exercise.id) {
            completedExerciseIDs.remove(exercise.id)
        } else {
            completedExerciseIDs.insert(exercise.id)
        }
    }

    func finishSession(progression: ProgressionService, modelContext: ModelContext) {
        guard sessionActive else { return }
        sessionActive = false
        let duration = max(1, Int(Date.now.timeIntervalSince(sessionStartTime)) / 60)
        let xp = sessionXPEarned
        progression.completeWorkout(
            disciplineName: currentDiscipline?.name ?? "General Training",
            exercisesCompleted: completedExerciseIDs.count,
            durationMinutes: duration,
            xpEarned: xp,
            context: modelContext
        )
        withAnimation(AppDesign.Anim.bounce) {
            showCompletionBanner = true
        }
        Task {
            try? await Task.sleep(for: .seconds(4))
            withAnimation(AppDesign.Anim.standard) {
                showCompletionBanner = false
                completedExerciseIDs.removeAll()
                currentDiscipline = nil
            }
        }
    }
}
