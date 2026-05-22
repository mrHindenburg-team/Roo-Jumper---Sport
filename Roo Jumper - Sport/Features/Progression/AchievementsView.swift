import SwiftUI

struct AchievementsView: View {

    @Environment(AppState.self) private var appState

    private var unlockedCount: Int {
        appState.progression.achievements.count(where: { $0.isUnlocked })
    }

    var body: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.lg) {
            summaryCard
            achievementGrid
        }
    }

    private var summaryCard: some View {
        HStack(spacing: AppDesign.Spacing.lg) {
            VStack(alignment: .leading, spacing: 4) {
                Text("\(unlockedCount) / \(appState.progression.achievements.count)")
                    .font(.system(size: 32, weight: .black, design: .rounded))
                    .foregroundStyle(AppDesign.Colors.electricLime)
                Text("Achievements Unlocked")
                    .font(AppDesign.Typography.body)
                    .foregroundStyle(AppDesign.Colors.dimWhite)
            }
            Spacer()
            ZStack {
                Circle()
                    .fill(AppDesign.Colors.electricLime.opacity(0.12))
                    .frame(width: 64, height: 64)
                Image(systemName: "trophy.fill")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(AppDesign.Colors.electricLime)
            }
        }
        .sportCard()
    }

    private var achievementGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: AppDesign.Spacing.sm) {
            ForEach(appState.progression.achievements) { achievement in
                AchievementCard(achievement: achievement)
            }
        }
    }
}

// MARK: - AchievementCard

private struct AchievementCard: View {
    let achievement: Achievement

    private var categoryColor: Color {
        switch achievement.category {
        case .milestone:   AppDesign.Colors.electricLime
        case .consistency: AppDesign.Colors.neonOrange
        case .mastery:     AppDesign.Colors.dynamicBlue
        case .exploration: AppDesign.Colors.neonCyan
        case .challenge:   AppDesign.Colors.neonOrange
        case .aiCoach:     AppDesign.Colors.dynamicBlue
        }
    }

    var body: some View {
        VStack(spacing: AppDesign.Spacing.sm) {
            ZStack {
                Circle()
                    .fill(achievement.isUnlocked ? categoryColor.opacity(0.15) : AppDesign.Colors.surface3)
                    .frame(width: 52, height: 52)

                Image(systemName: achievement.iconName)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(achievement.isUnlocked ? categoryColor : AppDesign.Colors.mutedText)
            }
            .glowShadow(achievement.isUnlocked ? categoryColor : .clear, radius: 12)

            VStack(spacing: 2) {
                Text(achievement.name)
                    .font(AppDesign.Typography.caption)
                    .foregroundStyle(achievement.isUnlocked ? AppDesign.Colors.brightWhite : AppDesign.Colors.dimWhite)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)

                if achievement.isUnlocked {
                    HStack(spacing: 3) {
                        Image(systemName: "bolt.fill")
                            .font(.system(size: 9))
                            .foregroundStyle(AppDesign.Colors.electricLime)
                        Text("+\(achievement.xpReward) XP")
                            .font(AppDesign.Typography.caption)
                            .foregroundStyle(AppDesign.Colors.electricLime)
                    }
                } else {
                    Text(achievement.description)
                        .font(.system(size: 9, design: .rounded))
                        .foregroundStyle(AppDesign.Colors.mutedText)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(AppDesign.Spacing.md)
        .background(achievement.isUnlocked ?
                    AnyShapeStyle(AppDesign.Colors.cardSurface) :
                    AnyShapeStyle(AppDesign.Colors.surface1))
        .clipShape(.rect(cornerRadius: AppDesign.Radius.lg))
        .overlay {
            RoundedRectangle(cornerRadius: AppDesign.Radius.lg)
                .strokeBorder(
                    achievement.isUnlocked ? categoryColor.opacity(0.4) : AppDesign.Colors.surface3,
                    lineWidth: 1
                )
        }
        .opacity(achievement.isUnlocked ? 1.0 : 0.5)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(achievement.name). \(achievement.isUnlocked ? "Unlocked" : "Locked: \(achievement.description)")")
    }
}

#Preview {
    ScrollView {
        AchievementsView()
            .padding()
    }
    .background(AppDesign.Colors.background)
    .environment(AppState(progress: UserProgress()))
}
