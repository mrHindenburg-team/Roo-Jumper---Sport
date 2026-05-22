import SwiftUI

struct JumpEvolutionView: View {

    @Environment(AppState.self) private var appState
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var selectedStageIndex = 0

    private var stages: [TrainingDataStore.EvolutionStage] { TrainingDataStore.evolutionStages }
    private var currentStage: TrainingDataStore.EvolutionStage { appState.progression.currentEvolutionStage }

    var body: some View {
        VStack(spacing: AppDesign.Spacing.lg) {
            evolutionProgressCard
            stageTimeline
            selectedStageDetail
        }
    }

    // MARK: - Evolution Progress Card

    private var evolutionProgressCard: some View {
        VStack(spacing: AppDesign.Spacing.md) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("EVOLUTION STAGE \(currentStage.index + 1)/\(stages.count)")
                        .font(.system(size: 10, weight: .black, design: .rounded))
                        .foregroundStyle(AppDesign.Colors.neonOrange)
                        .tracking(2)
                    Text(currentStage.title)
                        .font(AppDesign.Typography.headline)
                        .foregroundStyle(AppDesign.Colors.brightWhite)
                    Text(currentStage.subtitle)
                        .font(AppDesign.Typography.caption)
                        .foregroundStyle(AppDesign.Colors.dimWhite)
                }
                Spacer()
                Image(systemName: currentStage.iconName)
                    .font(.system(size: 40, weight: .bold))
                    .foregroundStyle(AppDesign.Colors.explosiveness)
            }

            if let next = appState.progression.nextEvolutionStage {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("Progress to: \(next.title)")
                            .font(AppDesign.Typography.caption)
                            .foregroundStyle(AppDesign.Colors.dimWhite)
                        Spacer()
                        Text("\(appState.progression.userProgress.totalXP) / \(next.xpRequired) XP")
                            .font(AppDesign.Typography.caption)
                            .foregroundStyle(AppDesign.Colors.neonOrange)
                    }
                    GlowingProgressBar(
                        value: appState.progression.evolutionProgress,
                        accentColor: AppDesign.Colors.neonOrange,
                        height: 8
                    )
                }
            } else {
                Text("Maximum Evolution Reached — Elite Performer")
                    .font(AppDesign.Typography.label)
                    .foregroundStyle(AppDesign.Colors.electricLime)
            }
        }
        .sportCard()
    }

    // MARK: - Stage Timeline

    private var stageTimeline: some View {
        HStack(spacing: 0) {
            ForEach(stages, id: \.index) { stage in
                stageNode(stage: stage)
                if stage.index < stages.count - 1 {
                    Rectangle()
                        .fill(stage.index < currentStage.index ? AppDesign.Colors.electricLime : AppDesign.Colors.surface3)
                        .frame(height: 2)
                }
            }
        }
        .padding(.horizontal, AppDesign.Spacing.md)
    }

    private func stageNode(stage: TrainingDataStore.EvolutionStage) -> some View {
        let isUnlocked = stage.index <= currentStage.index
        let isCurrent  = stage.index == currentStage.index
        return Button(action: { withAnimation(AppDesign.Anim.standard) { selectedStageIndex = stage.index } }) {
            VStack(spacing: 4) {
                ZStack {
                    Circle()
                        .fill(
                            isCurrent  ? AppDesign.Colors.electricLime :
                            isUnlocked ? AppDesign.Colors.electricLime.opacity(0.4) :
                                         AppDesign.Colors.surface3
                        )
                        .frame(width: 40, height: 40)

                    Image(systemName: stage.iconName)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(isUnlocked ? AppDesign.Colors.background : AppDesign.Colors.mutedText)
                }
                Text("S\(stage.index + 1)")
                    .font(AppDesign.Typography.caption)
                    .foregroundStyle(isCurrent ? AppDesign.Colors.electricLime : AppDesign.Colors.mutedText)
            }
        }
        .accessibilityLabel("Stage \(stage.index + 1): \(stage.title). \(isUnlocked ? "Unlocked" : "Locked")")
    }

    // MARK: - Stage Detail

    private var selectedStageDetail: some View {
        let stage = stages[selectedStageIndex]
        let isUnlocked = stage.index <= currentStage.index

        return VStack(alignment: .leading, spacing: AppDesign.Spacing.md) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(stage.title)
                        .font(AppDesign.Typography.title)
                        .foregroundStyle(AppDesign.Colors.brightWhite)
                    Text(stage.subtitle)
                        .font(AppDesign.Typography.caption)
                        .foregroundStyle(AppDesign.Colors.dimWhite)
                }
                Spacer()
                if !isUnlocked {
                    HStack(spacing: 4) {
                        Image(systemName: "lock.fill").font(.system(size: 11))
                        Text("\(stage.xpRequired) XP")
                    }
                    .font(AppDesign.Typography.caption)
                    .foregroundStyle(AppDesign.Colors.neonOrange)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(AppDesign.Colors.neonOrange.opacity(0.1))
                    .clipShape(.capsule)
                }
            }

            Text(stage.description)
                .font(AppDesign.Typography.body)
                .foregroundStyle(AppDesign.Colors.dimWhite)
                .lineSpacing(4)

            Text("Unlocks \(stage.unlockedDisciplineIndices.count) disciplines")
                .font(AppDesign.Typography.label)
                .foregroundStyle(isUnlocked ? AppDesign.Colors.electricLime : AppDesign.Colors.mutedText)
        }
        .sportCard()
        .animation(AppDesign.Anim.standard, value: selectedStageIndex)
    }
}

#Preview {
    ScrollView {
        JumpEvolutionView()
            .padding()
    }
    .background(AppDesign.Colors.background)
    .environment(AppState(progress: UserProgress()))
}
