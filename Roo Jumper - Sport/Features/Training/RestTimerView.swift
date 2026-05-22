import SwiftUI

struct RestTimerView: View {

    @Binding var isPresented: Bool

    @State private var selected = 60
    @State private var remaining = 60
    @State private var timerRunning = false

    private let durations = [30, 60, 90, 120]

    var body: some View {
        VStack(spacing: AppDesign.Spacing.lg) {
            header
            durationSelector
            progressRing
            actionButtons
        }
        .padding(.horizontal, AppDesign.Spacing.lg)
        .padding(.vertical, AppDesign.Spacing.xl)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(AppDesign.Colors.background)
        .presentationDetents([.medium])
        .presentationBackground(AppDesign.Colors.background)
        .presentationCornerRadius(AppDesign.Radius.xl)
        .sensoryFeedback(.impact(flexibility: .solid, intensity: 1.0), trigger: remaining == 0)
        .task(id: timerRunning) {
            guard timerRunning else { return }
            do {
                while remaining > 0 {
                    try await Task.sleep(for: .seconds(1))
                    remaining -= 1
                }
                timerRunning = false
                try await Task.sleep(for: .milliseconds(500))
                isPresented = false
            } catch {
                // Task cancelled (view dismissed early) — exit cleanly
            }
        }
    }

    // MARK: - Header

    private var header: some View {
        VStack(spacing: AppDesign.Spacing.xs) {
            Text("Rest")
                .font(AppDesign.Typography.display)
                .foregroundStyle(AppDesign.Colors.brightWhite)
            Text("Exercise Complete")
                .font(AppDesign.Typography.label)
                .foregroundStyle(AppDesign.Colors.electricLime)
        }
    }

    // MARK: - Duration Selector

    private var durationSelector: some View {
        HStack(spacing: AppDesign.Spacing.sm) {
            ForEach(durations, id: \.self) { duration in
                DurationButton(
                    duration: duration,
                    isSelected: selected == duration,
                    onSelect: { selectDuration(duration) }
                )
            }
        }
    }

    // MARK: - Progress Ring

    private var progressRing: some View {
        ZStack {
            Circle()
                .stroke(AppDesign.Colors.surface2, lineWidth: 8)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(AppDesign.Colors.electricLime, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(AppDesign.Anim.standard, value: remaining)

            VStack(spacing: 2) {
                Text("\(remaining)")
                    .font(.system(size: 48, weight: .black, design: .rounded))
                    .foregroundStyle(AppDesign.Colors.brightWhite)
                    .contentTransition(.numericText(countsDown: true))
                    .animation(AppDesign.Anim.standard, value: remaining)
                Text("sec")
                    .font(AppDesign.Typography.caption)
                    .foregroundStyle(AppDesign.Colors.dimWhite)
            }
        }
        .frame(width: 160, height: 160)
    }

    // MARK: - Action Buttons

    private var actionButtons: some View {
        HStack(spacing: AppDesign.Spacing.md) {
            Button("Skip Rest", action: dismiss)
                .font(AppDesign.Typography.label)
                .foregroundStyle(AppDesign.Colors.dimWhite)
                .frame(maxWidth: .infinity)
                .padding(.vertical, AppDesign.Spacing.md)
                .background(AppDesign.Colors.surface2)
                .clipShape(.capsule)

            if timerRunning {
                Button("Reset", action: resetTimer)
                    .font(AppDesign.Typography.label)
                    .foregroundStyle(AppDesign.Colors.dimWhite)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, AppDesign.Spacing.md)
                    .background(AppDesign.Colors.surface3)
                    .clipShape(.capsule)
            } else {
                Button("Start", action: startTimer)
                    .font(AppDesign.Typography.label)
                    .foregroundStyle(AppDesign.Colors.background)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, AppDesign.Spacing.md)
                    .background(AppDesign.Colors.electricLime)
                    .clipShape(.capsule)
            }
        }
        .animation(AppDesign.Anim.standard, value: timerRunning)
    }

    // MARK: - Helpers

    private var progress: Double {
        guard selected > 0 else { return 0 }
        return Double(remaining) / Double(selected)
    }

    private func selectDuration(_ duration: Int) {
        timerRunning = false
        selected = duration
        remaining = duration
        timerRunning = true
    }

    private func startTimer() {
        timerRunning = true
    }

    private func resetTimer() {
        timerRunning = false
        remaining = selected
    }

    private func dismiss() {
        isPresented = false
    }
}

// MARK: - DurationButton

private struct DurationButton: View {
    let duration: Int
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            Text(label)
                .font(AppDesign.Typography.label)
                .foregroundStyle(isSelected ? AppDesign.Colors.background : AppDesign.Colors.dimWhite)
                .frame(maxWidth: .infinity)
                .padding(.vertical, AppDesign.Spacing.sm)
                .background(isSelected ? AppDesign.Colors.electricLime : AppDesign.Colors.surface2)
                .clipShape(.capsule)
        }
        .animation(AppDesign.Anim.standard, value: isSelected)
        .accessibilityLabel("\(duration) seconds")
    }

    private var label: String {
        duration < 60 ? "\(duration)s" : "\(duration / 60)m\(duration % 60 == 0 ? "" : "\(duration % 60)s")"
    }
}

// MARK: - Preview

#Preview {
    @Previewable @State var shown = true
    RestTimerView(isPresented: $shown)
}
