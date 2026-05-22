import SwiftUI

enum AppTab: String, CaseIterable {
    case home       = "Home"
    case training   = "Training"
    case education  = "Education"
    case aiCoach    = "AI Coach"
    case progress   = "Progress"
}

struct MainTabView: View {

    @State private var selectedTab = AppTab.home
    @Environment(AppState.self) private var appState

    var body: some View {
        ZStack(alignment: .top) {
            tabView
            achievementBanner
        }
    }

    private var tabView: some View {
        TabView(selection: $selectedTab) {
            Tab("Home", systemImage: "house.fill", value: AppTab.home) {
                HomeView()
            }
            Tab("Training", systemImage: "bolt.fill", value: AppTab.training) {
                TrainingView()
            }
            Tab("Education", systemImage: "book.fill", value: AppTab.education) {
                EducationView()
            }
            Tab("AI Coach", systemImage: "brain.head.profile", value: AppTab.aiCoach) {
                AICoachView()
            }
            Tab("Progress", systemImage: "chart.line.uptrend.xyaxis", value: AppTab.progress) {
                ProgressionView()
            }
        }
        .tint(AppDesign.Colors.electricLime)
        .toolbarBackground(AppDesign.Colors.surface1, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
    }

    @ViewBuilder
    private var achievementBanner: some View {
        if let achievement = appState.progression.recentlyUnlocked {
            AchievementUnlockBanner(achievement: achievement)
                .padding(.top, AppDesign.Spacing.sm)
                .transition(.move(edge: .top).combined(with: .opacity))
                .zIndex(10)
        }
    }
}

// MARK: - Achievement Unlock Banner

private struct AchievementUnlockBanner: View {

    let achievement: Achievement
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var scale: Double = 0.8

    var body: some View {
        HStack(spacing: AppDesign.Spacing.sm) {
            Image(systemName: achievement.iconName)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(AppDesign.Colors.electricLime)
            VStack(alignment: .leading, spacing: 2) {
                Text("Achievement Unlocked!")
                    .font(AppDesign.Typography.caption)
                    .foregroundStyle(AppDesign.Colors.electricLime)
                Text(achievement.name)
                    .font(AppDesign.Typography.label)
                    .foregroundStyle(AppDesign.Colors.brightWhite)
            }
            Spacer()
            HStack(spacing: 3) {
                Image(systemName: "bolt.fill")
                    .font(.system(size: 9))
                    .foregroundStyle(AppDesign.Colors.electricLime)
                Text("+\(achievement.xpReward)")
                    .font(AppDesign.Typography.caption)
                    .foregroundStyle(AppDesign.Colors.electricLime)
            }
        }
        .padding(.horizontal, AppDesign.Spacing.md)
        .padding(.vertical, AppDesign.Spacing.sm)
        .background(
            ZStack {
                AppDesign.Colors.surface1
                    .clipShape(.rect(cornerRadius: AppDesign.Radius.lg))
                RoundedRectangle(cornerRadius: AppDesign.Radius.lg)
                    .strokeBorder(AppDesign.Colors.electricLime.opacity(0.6), lineWidth: 1.5)
            }
        )
        .shadow(color: AppDesign.Colors.electricLime.opacity(0.35), radius: 14, x: 0, y: 4)
        .padding(.horizontal, AppDesign.Spacing.lg)
        .scaleEffect(scale)
        .onAppear {
            guard !reduceMotion else { scale = 1.0; return }
            withAnimation(AppDesign.Anim.bounce) { scale = 1.0 }
        }
        .accessibilityLabel("Achievement unlocked: \(achievement.name). \(achievement.xpReward) XP earned.")
    }
}

#Preview {
    MainTabView()
        .environment(AppState(progress: UserProgress()))
        .environment(SubscriptionManagerBPV())
}
