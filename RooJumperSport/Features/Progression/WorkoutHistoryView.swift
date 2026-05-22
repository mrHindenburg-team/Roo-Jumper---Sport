import SwiftUI
import SwiftData

// MARK: - WorkoutHistoryView

struct WorkoutHistoryView: View {

    @Query(sort: \TrainingSessionRecord.date, order: .reverse)
    private var sessions: [TrainingSessionRecord]

    var body: some View {
        Group {
            if sessions.isEmpty {
                emptyState
            } else {
                sessionList
            }
        }
    }

    // MARK: - Session List

    private var sessionList: some View {
        ScrollView {
            LazyVStack(spacing: AppDesign.Spacing.sm) {
                ForEach(sessions) { session in
                    SessionRow(session: session)
                }
            }
            .padding(.horizontal, AppDesign.Spacing.md)
            .padding(.vertical, AppDesign.Spacing.md)
            .padding(.bottom, AppDesign.Spacing.xxl)
        }
        .scrollIndicators(.hidden)
    }

    // MARK: - Empty State

    private var emptyState: some View {
        VStack(spacing: AppDesign.Spacing.md) {
            Image(systemName: "calendar.badge.exclamationmark")
                .font(.system(size: 52, weight: .semibold))
                .foregroundStyle(AppDesign.Colors.dimWhite)
                .accessibilityHidden(true)

            VStack(spacing: AppDesign.Spacing.xs) {
                Text("No Sessions Yet")
                    .font(AppDesign.Typography.title)
                    .foregroundStyle(AppDesign.Colors.brightWhite)

                Text("Complete a training session to see your history here.")
                    .font(AppDesign.Typography.body)
                    .foregroundStyle(AppDesign.Colors.dimWhite)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(AppDesign.Spacing.xl)
    }
}

// MARK: - SessionRow

private struct SessionRow: View {

    let session: TrainingSessionRecord

    private static let dayFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "d"
        return f
    }()

    private static let monthFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "MMM"
        return f
    }()

    var body: some View {
        HStack(spacing: AppDesign.Spacing.sm) {
            dateColumn
            accentLine
            contentColumn
        }
        .padding(AppDesign.Spacing.md)
        .background(AppDesign.Colors.surface1)
        .clipShape(.rect(cornerRadius: AppDesign.Radius.md))
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityDescription)
    }

    // MARK: - Date Column

    private var dateColumn: some View {
        VStack(spacing: 1) {
            Text(Self.dayFormatter.string(from: session.date))
                .font(.system(.title2, design: .rounded, weight: .bold))
                .foregroundStyle(AppDesign.Colors.brightWhite)

            Text(Self.monthFormatter.string(from: session.date).uppercased())
                .font(.system(.caption2, design: .rounded, weight: .medium))
                .foregroundStyle(AppDesign.Colors.dimWhite)
        }
        .frame(width: 40)
    }

    // MARK: - Accent Line

    private var accentLine: some View {
        Capsule()
            .fill(AppDesign.Colors.electricLime)
            .frame(width: 2)
            .frame(maxHeight: .infinity)
    }

    // MARK: - Content Column

    private var contentColumn: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.xs) {
            Text(session.disciplineName)
                .font(AppDesign.Typography.label)
                .foregroundStyle(AppDesign.Colors.brightWhite)
                .lineLimit(1)

            chipRow
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var chipRow: some View {
        HStack(spacing: AppDesign.Spacing.xs) {
            StatChip(
                icon: "checkmark.circle",
                label: "\(session.exercisesCompleted)",
                color: AppDesign.Colors.electricLime
            )
            StatChip(
                icon: "clock",
                label: "\(session.durationMinutes) min",
                color: AppDesign.Colors.dynamicBlue
            )
            StatChip(
                icon: "bolt.fill",
                label: "\(session.xpEarned) XP",
                color: AppDesign.Colors.neonOrange
            )
        }
    }

    // MARK: - Accessibility

    private var accessibilityDescription: String {
        let day = Self.dayFormatter.string(from: session.date)
        let month = Self.monthFormatter.string(from: session.date)
        return "\(session.disciplineName), \(day) \(month). " +
               "\(session.exercisesCompleted) exercises, " +
               "\(session.durationMinutes) minutes, " +
               "\(session.xpEarned) XP earned."
    }
}

// MARK: - StatChip

private struct StatChip: View {

    let icon: String
    let label: String
    let color: Color

    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: icon)
                .font(.system(.caption2, design: .rounded, weight: .semibold))
                .foregroundStyle(color)

            Text(label)
                .font(AppDesign.Typography.caption)
                .foregroundStyle(AppDesign.Colors.dimWhite)
        }
        .padding(.horizontal, AppDesign.Spacing.xs + 2)
        .padding(.vertical, 3)
        .background(color.opacity(0.10))
        .clipShape(.capsule)
    }
}

// MARK: - Preview

#Preview {
    ZStack {
        AppDesign.Colors.background.ignoresSafeArea()
        WorkoutHistoryView()
    }
    .modelContainer(for: TrainingSessionRecord.self, inMemory: true)
}
