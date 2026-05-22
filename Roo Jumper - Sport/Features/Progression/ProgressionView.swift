import SwiftUI

struct ProgressionView: View {

    @Environment(AppState.self) private var appState
    @State private var showEvolution = false
    @State private var showJumpLogger = false
    @State private var selectedTab: ProgressTab = .overview

    enum ProgressTab: String, CaseIterable {
        case overview     = "Overview"
        case evolution    = "Evolution"
        case achievements = "Achievements"
        case history      = "History"
    }

    var body: some View {
        NavigationStack {
            ZStack {
                AppDesign.Colors.background.ignoresSafeArea()
                VStack(spacing: 0) {
                    tabPicker
                    ScrollView {
                        LazyVStack(spacing: AppDesign.Spacing.lg) {
                            switch selectedTab {
                            case .overview:     overviewContent
                            case .evolution:    evolutionContent
                            case .achievements: achievementsContent
                            case .history:      historyContent
                            }
                        }
                        .padding(AppDesign.Spacing.md)
                        .padding(.bottom, AppDesign.Spacing.xxl)
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .navigationTitle("Progress")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { showJumpLogger = true }) {
                        Label("Log Jump", systemImage: "plus.circle.fill")
                            .font(AppDesign.Typography.label)
                            .foregroundStyle(AppDesign.Colors.electricLime)
                    }
                    .accessibilityLabel("Log a jump measurement")
                }
            }
            .sheet(isPresented: $showJumpLogger) {
                JumpLoggerView()
            }
        }
    }

    // MARK: - Tab Picker

    private var tabPicker: some View {
        HStack(spacing: 0) {
            ForEach(ProgressTab.allCases, id: \.self) { tab in
                Button(action: {
                    withAnimation(AppDesign.Anim.standard) {
                        selectedTab = tab
                    }
                }) {
                    Text(tab.rawValue)
                        .font(AppDesign.Typography.label)
                        .foregroundStyle(selectedTab == tab ? AppDesign.Colors.background : AppDesign.Colors.dimWhite)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, AppDesign.Spacing.sm)
                        .background(
                            selectedTab == tab
                            ? AppDesign.Colors.electricLime
                            : AppDesign.Colors.surface2
                        )
                }
                .animation(AppDesign.Anim.fast, value: selectedTab)
            }
        }
        .clipShape(.rect(cornerRadius: AppDesign.Radius.full))
        .padding(.horizontal, AppDesign.Spacing.md)
        .padding(.vertical, AppDesign.Spacing.sm)
        .background(AppDesign.Colors.surface1)
    }

    // MARK: - Overview

    private var overviewContent: some View {
        VStack(spacing: AppDesign.Spacing.lg) {
            levelCard
            metricsGrid
            streakHistory
        }
    }

    private var levelCard: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.md) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("LEVEL \(appState.progression.userProgress.currentLevel)")
                        .font(.system(size: 11, weight: .black, design: .rounded))
                        .foregroundStyle(AppDesign.Colors.electricLime)
                        .tracking(3)
                    Text(appState.progression.userProgress.levelTitle)
                        .font(AppDesign.Typography.headline)
                        .foregroundStyle(AppDesign.Colors.brightWhite)
                }
                Spacer()
                XPBadge(xp: appState.progression.userProgress.totalXP)
            }
            GlowingProgressBar(
                value: appState.progression.userProgress.progressToNextLevel,
                accentColor: AppDesign.Colors.electricLime,
                height: 10,
                showLabel: true,
                labelText: "Next Level: \(appState.progression.userProgress.xpForNextLevel - (appState.progression.userProgress.totalXP % appState.progression.userProgress.xpForNextLevel)) XP needed"
            )
        }
        .sportCard()
    }

    private var metricsGrid: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.sm) {
            Label("Performance Metrics", systemImage: "chart.bar.fill")
                .font(AppDesign.Typography.title3)
                .foregroundStyle(AppDesign.Colors.brightWhite)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: AppDesign.Spacing.sm) {
                ForEach(appState.progression.metrics.prefix(6)) { metric in
                    MetricCardView(metric: metric)
                }
            }
        }
    }

    private var streakHistory: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.sm) {
            Label("Training Consistency", systemImage: "flame.fill")
                .font(AppDesign.Typography.title3)
                .foregroundStyle(AppDesign.Colors.brightWhite)
            HStack(spacing: AppDesign.Spacing.sm) {
                consistencyCard(
                    title: "Current Streak",
                    value: "\(appState.progression.userProgress.currentStreak)",
                    unit: "days",
                    icon: "flame.fill",
                    color: AppDesign.Colors.neonOrange
                )
                consistencyCard(
                    title: "Longest Streak",
                    value: "\(appState.progression.userProgress.longestStreak)",
                    unit: "days",
                    icon: "trophy.fill",
                    color: AppDesign.Colors.electricLime
                )
                consistencyCard(
                    title: "Total Sessions",
                    value: "\(appState.progression.userProgress.totalWorkoutsCompleted)",
                    unit: "total",
                    icon: "checkmark.circle.fill",
                    color: AppDesign.Colors.dynamicBlue
                )
            }
        }
    }

    // MARK: - Evolution

    private var evolutionContent: some View {
        JumpEvolutionView()
    }

    // MARK: - Achievements

    private var achievementsContent: some View {
        AchievementsView()
    }

    // MARK: - History

    private var historyContent: some View {
        WorkoutHistoryView()
    }

    // MARK: - Helpers

    private func consistencyCard(title: String, value: String, unit: String, icon: String, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(color)
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text(value)
                    .font(.system(size: 24, weight: .black, design: .rounded))
                    .foregroundStyle(AppDesign.Colors.brightWhite)
                Text(unit)
                    .font(AppDesign.Typography.caption)
                    .foregroundStyle(AppDesign.Colors.dimWhite)
            }
            Text(title)
                .font(AppDesign.Typography.caption)
                .foregroundStyle(AppDesign.Colors.mutedText)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .sportCard()
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title): \(value) \(unit)")
    }
}

// MARK: - XPBadge

private struct XPBadge: View {
    let xp: Int

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "bolt.fill")
                .font(.system(size: 10, weight: .bold))
                .foregroundStyle(AppDesign.Colors.electricLime)
            Text("\(xp) XP")
                .font(AppDesign.Typography.label)
                .foregroundStyle(AppDesign.Colors.electricLime)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(AppDesign.Colors.electricLime.opacity(0.12))
        .clipShape(.capsule)
    }
}

#Preview {
    ProgressionView()
        .environment(AppState(progress: UserProgress()))
        .environment(SubscriptionManagerBPV())
}
