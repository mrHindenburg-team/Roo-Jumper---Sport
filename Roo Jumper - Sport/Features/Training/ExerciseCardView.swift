import SwiftUI

struct ExerciseCardView: View {

    let exercise: Exercise
    var isCompleted: Bool = false
    var onToggle: (() -> Void)? = nil

    private var categoryColor: Color {
        switch exercise.category {
        case .plyometric:   AppDesign.Colors.electricLime
        case .strength:     AppDesign.Colors.neonOrange
        case .mobility:     AppDesign.Colors.neonCyan
        case .coordination: AppDesign.Colors.dynamicBlue
        case .reaction:     AppDesign.Colors.neonOrange
        case .recovery:     AppDesign.Colors.dimWhite
        case .technique:    AppDesign.Colors.electricLime
        }
    }

    var body: some View {
        HStack(spacing: AppDesign.Spacing.md) {
            checkmarkButton
            exerciseInfo
            Spacer()
            metaInfo
        }
        .padding(AppDesign.Spacing.md)
        .background(
            isCompleted
            ? AnyShapeStyle(AppDesign.Colors.electricLime.opacity(0.07))
            : AnyShapeStyle(AppDesign.Colors.cardSurface)
        )
        .clipShape(.rect(cornerRadius: AppDesign.Radius.lg))
        .overlay {
            RoundedRectangle(cornerRadius: AppDesign.Radius.lg)
                .strokeBorder(
                    isCompleted
                    ? AppDesign.Colors.electricLime.opacity(0.4)
                    : AppDesign.Colors.surface3,
                    lineWidth: 1
                )
        }
        .animation(AppDesign.Anim.standard, value: isCompleted)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(exercise.name), \(exercise.sets) sets of \(exercise.repsDisplay). \(isCompleted ? "Completed." : "Not completed.")")
    }

    private var checkmarkButton: some View {
        Button(action: { onToggle?() }) {
            Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(isCompleted ? AppDesign.Colors.electricLime : AppDesign.Colors.graphite)
        }
        .sensoryFeedback(.impact(flexibility: .soft), trigger: isCompleted)
        .accessibilityLabel(isCompleted ? "Mark incomplete" : "Mark complete")
    }

    private var exerciseInfo: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 6) {
                Label(exercise.category.rawValue, systemImage: exercise.category.iconName)
                    .font(AppDesign.Typography.caption)
                    .foregroundStyle(categoryColor)
                if exercise.isPremium {
                    Label("Premium", systemImage: "lock.fill")
                        .font(AppDesign.Typography.caption)
                        .foregroundStyle(AppDesign.Colors.neonOrange)
                }
            }
            Text(exercise.name)
                .font(AppDesign.Typography.label)
                .foregroundStyle(AppDesign.Colors.brightWhite)
                .strikethrough(isCompleted, color: AppDesign.Colors.dimWhite)
        }
    }

    private var metaInfo: some View {
        VStack(alignment: .trailing, spacing: 4) {
            Text("\(exercise.sets)×\(exercise.repsDisplay)")
                .font(AppDesign.Typography.label)
                .foregroundStyle(AppDesign.Colors.dimWhite)
            HStack(spacing: 3) {
                Image(systemName: "bolt.fill")
                    .font(.system(size: 9, weight: .bold))
                    .foregroundStyle(AppDesign.Colors.electricLime)
                Text("+\(exercise.xpReward)")
                    .font(AppDesign.Typography.caption)
                    .foregroundStyle(AppDesign.Colors.electricLime)
            }
        }
    }
}

#Preview {
    VStack(spacing: 8) {
        ExerciseCardView(exercise: TrainingDataStore.exercises[0], isCompleted: false)
        ExerciseCardView(exercise: TrainingDataStore.exercises[1], isCompleted: true)
    }
    .padding()
    .background(AppDesign.Colors.background)
}
