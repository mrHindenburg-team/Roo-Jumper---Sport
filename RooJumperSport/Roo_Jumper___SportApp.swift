import SwiftUI
import SwiftData

@main
struct RooJumperSport: App {

    @State private var purchaseManager = SubscriptionManagerBPV()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(purchaseManager)
        }
        .modelContainer(for: [UserProgress.self, TrainingSessionRecord.self])
    }
}
