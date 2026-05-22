import SwiftUI
import SwiftData

struct HomeView: View {

    @Environment(AppState.self) private var appState
    @Environment(SubscriptionManagerBPV.self) private var purchaseManager
    @Query(sort: \TrainingSessionRecord.date, order: .reverse) private var recentSessions: [TrainingSessionRecord]
    @State private var viewModel = HomeViewModel()
    @State private var showStore = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        NavigationStack {
            ZStack {
                AppDesign.Colors.background.ignoresSafeArea()
                scrollContent
            }
            .navigationTitle("")
            .toolbar { toolbarContent }
            .sheet(isPresented: $showStore) {
                StoreView()
            }
        }
    }

    // MARK: - Content

    private var scrollContent: some View {
        ScrollView {
            LazyVStack(spacing: AppDesign.Spacing.lg) {
                headerSection
                storeButton
                weeklyActivitySection
                aiCoachSection
                metricsSection
                dailyChallengeSection
                trajectorySection
                streakSection
            }
            .padding(.horizontal, AppDesign.Spacing.md)
            .padding(.bottom, AppDesign.Spacing.xxl)
        }
        .scrollIndicators(.hidden)
    }

    // MARK: - Toolbar

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(viewModel.greeting)
                .font(AppDesign.Typography.label)
                .foregroundStyle(AppDesign.Colors.dimWhite)
        }
        ToolbarItem(placement: .topBarTrailing) {
            HStack(spacing: AppDesign.Spacing.sm) {
                Button(action: { showStore = true }) {
                    Label("Upgrade", systemImage: "bolt.fill")
                        .font(AppDesign.Typography.caption)
                        .foregroundStyle(AppDesign.Colors.background)
                        .padding(.horizontal, AppDesign.Spacing.sm)
                        .padding(.vertical, AppDesign.Spacing.xs)
                        .background(AppDesign.Colors.neonOrange)
                        .clipShape(.capsule)
                }
                levelBadge
            }
        }
    }

    private var levelBadge: some View {
        HStack(spacing: 4) {
            Image(systemName: "bolt.fill")
                .font(.system(size: 11, weight: .bold))
                .foregroundStyle(AppDesign.Colors.electricLime)
            Text("Lv. \(appState.progression.userProgress.currentLevel)")
                .font(AppDesign.Typography.label)
                .foregroundStyle(AppDesign.Colors.electricLime)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(AppDesign.Colors.electricLime.opacity(0.12))
        .clipShape(.capsule)
    }

    // MARK: - Sections

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.sm) {
            Text("ROO JUMPER")
                .font(.system(size: 11, weight: .black, design: .rounded))
                .foregroundStyle(AppDesign.Colors.electricLime)
                .tracking(4)

            Text("Athletic Performance Hub")
                .font(AppDesign.Typography.headline)
                .foregroundStyle(AppDesign.Colors.brightWhite)

            Text(viewModel.motivationalQuote)
                .font(AppDesign.Typography.body)
                .foregroundStyle(AppDesign.Colors.dimWhite)
                .lineSpacing(4)
                .padding(.top, AppDesign.Spacing.xs)

            GlowingProgressBar(
                value: appState.progression.userProgress.progressToNextLevel,
                accentColor: AppDesign.Colors.electricLime,
                showLabel: true,
                labelText: appState.progression.userProgress.levelTitle
            )
            .padding(.top, AppDesign.Spacing.sm)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, AppDesign.Spacing.sm)
    }

    private var storeButton: some View {
        Button(action: { showStore = true }) {
            HStack(spacing: AppDesign.Spacing.md) {
                ZStack {
                    Circle()
                        .fill(AppDesign.Colors.neonOrange.opacity(0.15))
                        .frame(width: 44, height: 44)
                    Image(systemName: "crown.fill")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(AppDesign.Colors.neonOrange)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("Unlock Premium")
                        .font(AppDesign.Typography.label)
                        .foregroundStyle(AppDesign.Colors.brightWhite)
                    Text("Unlimited AI · Premium Disciplines · Analytics")
                        .font(AppDesign.Typography.caption)
                        .foregroundStyle(AppDesign.Colors.dimWhite)
                }
                Spacer()
                Text("View Plans")
                    .font(AppDesign.Typography.caption)
                    .foregroundStyle(AppDesign.Colors.background)
                    .padding(.horizontal, AppDesign.Spacing.sm)
                    .padding(.vertical, AppDesign.Spacing.xs)
                    .background(AppDesign.Colors.neonOrange)
                    .clipShape(.capsule)
            }
            .padding(AppDesign.Spacing.md)
            .background(
                LinearGradient(
                    colors: [AppDesign.Colors.neonOrange.opacity(0.12), AppDesign.Colors.surface1],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(.rect(cornerRadius: AppDesign.Radius.lg))
            .overlay {
                RoundedRectangle(cornerRadius: AppDesign.Radius.lg)
                    .strokeBorder(AppDesign.Colors.neonOrange.opacity(0.4), lineWidth: 1)
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Unlock Premium. View plans for Unlimited AI and premium disciplines.")
    }

    private var weeklyActivitySection: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.sm) {
            sectionHeader(title: "This Week", subtitle: "Training activity", icon: "calendar.badge.checkmark")
            HStack(spacing: 0) {
                ForEach(weekDays, id: \.label) { day in
                    VStack(spacing: AppDesign.Spacing.xs) {
                        ZStack {
                            Circle()
                                .fill(day.trained ? AppDesign.Colors.electricLime : AppDesign.Colors.surface2)
                                .frame(width: 36, height: 36)
                            if day.trained {
                                Image(systemName: "bolt.fill")
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundStyle(AppDesign.Colors.background)
                            }
                        }
                        .overlay {
                            if day.isToday {
                                Circle()
                                    .strokeBorder(AppDesign.Colors.electricLime, lineWidth: 2)
                                    .frame(width: 38, height: 38)
                            }
                        }
                        Text(day.label)
                            .font(AppDesign.Typography.caption)
                            .foregroundStyle(day.isToday ? AppDesign.Colors.electricLime : AppDesign.Colors.mutedText)
                    }
                    .frame(maxWidth: .infinity)
                    .accessibilityLabel("\(day.fullLabel): \(day.trained ? "Trained" : "Rest day")")
                }
            }
            .padding(AppDesign.Spacing.md)
            .background(AppDesign.Colors.surface1)
            .clipShape(.rect(cornerRadius: AppDesign.Radius.lg))
        }
    }

    private var weekDays: [WeekDay] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date.now)
        let shortFormatter = DateFormatter()
        shortFormatter.dateFormat = "E"
        let dayFormatter = DateFormatter()
        dayFormatter.dateStyle = .full
        return (0..<7).map { offset in
            let date = calendar.date(byAdding: .day, value: -(6 - offset), to: today)!
            return WeekDay(
                label: String(shortFormatter.string(from: date).prefix(1)),
                fullLabel: dayFormatter.string(from: date),
                trained: recentSessions.contains { calendar.isDate($0.date, inSameDayAs: date) },
                isToday: calendar.isDateInToday(date)
            )
        }
    }

    private struct WeekDay {
        let label: String
        let fullLabel: String
        let trained: Bool
        let isToday: Bool
    }

    private var aiCoachSection: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.sm) {
            sectionHeader(title: "AI Coach", subtitle: "Powered by Apple Intelligence", icon: "brain.head.profile")
            AICoachPreviewCard()
        }
    }

    private var metricsSection: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.sm) {
            sectionHeader(title: "Performance Metrics", subtitle: "Your athletic snapshot", icon: "chart.bar.fill")
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: AppDesign.Spacing.sm) {
                ForEach(appState.progression.metrics.prefix(4)) { metric in
                    MetricCardView(metric: metric)
                }
            }
        }
    }

    private var dailyChallengeSection: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.sm) {
            sectionHeader(title: "Daily Challenge", subtitle: viewModel.dailyChallengeTitle, icon: "target")
            dailyChallengeCard
        }
    }

    private var dailyChallengeCard: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.md) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.dailyChallengeDescription)
                        .font(AppDesign.Typography.body)
                        .foregroundStyle(AppDesign.Colors.brightWhite)
                    HStack(spacing: 4) {
                        Image(systemName: "bolt.fill")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(AppDesign.Colors.electricLime)
                        Text("+\(viewModel.dailyChallengeXP) XP")
                            .font(AppDesign.Typography.label)
                            .foregroundStyle(AppDesign.Colors.electricLime)
                    }
                }
                Spacer()
                Button(
                    action: viewModel.completeDailyChallenge,
                    label: {
                        Image(systemName: viewModel.isDailyChallengeCompleted ? "checkmark.circle.fill" : "play.circle.fill")
                            .font(.system(size: 44))
                            .foregroundStyle(
                                viewModel.isDailyChallengeCompleted ? AppDesign.Colors.electricLime : AppDesign.Colors.neonOrange
                            )
                    }
                )
                .accessibilityLabel(viewModel.isDailyChallengeCompleted ? "Challenge completed" : "Start challenge")
                .sensoryFeedback(.impact(flexibility: .solid), trigger: viewModel.isDailyChallengeCompleted)
            }
        }
        .sportCard()
    }

    private var trajectorySection: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.sm) {
            sectionHeader(title: "Jump Trajectory", subtitle: "Parabolic motion model", icon: "arrow.up.forward.circle.fill")
            JumpTrajectoryView()
                .frame(height: 100)
                .padding(AppDesign.Spacing.md)
                .background(AppDesign.Colors.cardSurface)
                .clipShape(.rect(cornerRadius: AppDesign.Radius.lg))
        }
    }

    private var streakSection: some View {
        HStack(spacing: AppDesign.Spacing.sm) {
            streakCard(
                title: "Current Streak",
                value: appState.progression.userProgress.currentStreak,
                unit: "days",
                icon: "flame.fill",
                color: AppDesign.Colors.neonOrange
            )
            streakCard(
                title: "Total Workouts",
                value: appState.progression.userProgress.totalWorkoutsCompleted,
                unit: "sessions",
                icon: "checkmark.circle.fill",
                color: AppDesign.Colors.electricLime
            )
        }
    }

    private func streakCard(title: String, value: Int, unit: String, icon: String, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Label(title, systemImage: icon)
                .font(AppDesign.Typography.caption)
                .foregroundStyle(color)
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text("\(value)")
                    .font(.system(size: 32, weight: .black, design: .rounded))
                    .foregroundStyle(AppDesign.Colors.brightWhite)
                Text(unit)
                    .font(AppDesign.Typography.caption)
                    .foregroundStyle(AppDesign.Colors.dimWhite)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .sportCard()
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title): \(value) \(unit)")
    }

    // MARK: - Helpers

    private func sectionHeader(title: String, subtitle: String, icon: String) -> some View {
        HStack(spacing: AppDesign.Spacing.sm) {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(AppDesign.Colors.electricLime)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(AppDesign.Typography.title3)
                    .foregroundStyle(AppDesign.Colors.brightWhite)
                Text(subtitle)
                    .font(AppDesign.Typography.caption)
                    .foregroundStyle(AppDesign.Colors.mutedText)
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(AppState(progress: UserProgress()))
        .environment(SubscriptionManagerBPV())
}
