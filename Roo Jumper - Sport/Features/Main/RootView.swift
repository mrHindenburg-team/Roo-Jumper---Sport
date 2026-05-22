import SwiftUI

// Manages the top-level flow: splash → onboarding → main app.
struct RootView: View {

    @Environment(AppState.self) private var appState

    var body: some View {
        @Bindable var state = appState
        ZStack {
            if state.showSplash {
                SplashView(isVisible: $state.showSplash)
                    .transition(.opacity)
            } else if !state.hasSeenOnboarding {
                OnboardingView(hasSeenOnboarding: $state.hasSeenOnboarding)
                    .transition(.opacity)
            } else {
                MainTabView()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.45), value: state.showSplash)
        .animation(.easeInOut(duration: 0.45), value: state.hasSeenOnboarding)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    RootView()
        .environment(AppState(progress: UserProgress()))
        .environment(SubscriptionManagerBPV())
}
