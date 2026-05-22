import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var progressRecords: [UserProgress]
    @Environment(\.modelContext) private var modelContext
    @State private var appState: AppState?

    var body: some View {
        Group {
            if let state = appState {
                RootView()
                    .environment(state)
            } else {
                splashPlaceholder
                    .task { await setupAppState() }
            }
        }
    }

    private var splashPlaceholder: some View {
        ZStack {
            AppDesign.Colors.background.ignoresSafeArea()
            ProgressView()
                .tint(AppDesign.Colors.electricLime)
        }
    }

    private func setupAppState() async {
        let progress: UserProgress
        if let existing = progressRecords.first {
            progress = existing
        } else {
            let newProgress = UserProgress()
            modelContext.insert(newProgress)
            try? modelContext.save()
            progress = newProgress
        }
        appState = AppState(progress: progress)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [UserProgress.self, TrainingSessionRecord.self], inMemory: true)
        .environment(SubscriptionManagerBPV())
}
