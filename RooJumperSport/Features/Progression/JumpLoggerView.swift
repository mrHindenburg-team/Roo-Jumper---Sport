import SwiftUI

struct JumpLoggerView: View {

    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var selectedType: JumpMetric.MetricType = .verticalJump
    @State private var inputValue: Double = 0
    @State private var showSuccess = false

    var body: some View {
        NavigationStack {
            ZStack {
                AppDesign.Colors.background.ignoresSafeArea()
                ScrollView {
                    LazyVStack(spacing: AppDesign.Spacing.lg) {
                        inputCard
                        personalRecordsSection
                        recentHistorySection
                    }
                    .padding(AppDesign.Spacing.md)
                    .padding(.bottom, AppDesign.Spacing.xxl)
                }
                .scrollIndicators(.hidden)
            }
            .navigationTitle("Log Jump")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Done", action: dismiss.callAsFunction)
                        .font(AppDesign.Typography.body)
                        .foregroundStyle(AppDesign.Colors.electricLime)
                }
            }
        }
    }

    // MARK: - Input Card

    private var inputCard: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.md) {
            typeChipScroll
            inputRow
            if let pr = appState.progression.latestValue(for: selectedType) {
                Text("Current record: \(pr, format: .number.precision(.fractionLength(1))) \(selectedType.unit)")
                    .font(AppDesign.Typography.caption)
                    .foregroundStyle(AppDesign.Colors.dimWhite)
            }
        }
        .sportCard()
    }

    private var typeChipScroll: some View {
        ScrollView(.horizontal) {
            HStack(spacing: AppDesign.Spacing.sm) {
                ForEach(JumpMetric.MetricType.allCases, id: \.self) { type in
                    TypeChip(
                        type: type,
                        isSelected: selectedType == type,
                        action: selectType(type)
                    )
                }
            }
            .padding(.vertical, AppDesign.Spacing.xs)
        }
        .scrollIndicators(.hidden)
    }

    private var inputRow: some View {
        HStack(spacing: AppDesign.Spacing.sm) {
            TextField("0", value: $inputValue, format: .number.precision(.fractionLength(1)))
                .keyboardType(.decimalPad)
                .font(.system(size: 44, weight: .black, design: .rounded))
                .foregroundStyle(AppDesign.Colors.brightWhite)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity)

            Text(selectedType.unit)
                .font(AppDesign.Typography.title3)
                .foregroundStyle(AppDesign.Colors.dimWhite)
                .frame(minWidth: 36, alignment: .leading)

            logButton
        }
    }

    private var logButton: some View {
        Button {
            logMetric()
        } label: {
            Text("Log metric")
            ZStack {
                if showSuccess {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 48))
                        .foregroundStyle(AppDesign.Colors.electricLime)
                        .transition(.scale.combined(with: .opacity))
                } else {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 48))
                        .foregroundStyle(
                            inputValue > 0
                            ? AppDesign.Colors.electricLime
                            : AppDesign.Colors.mutedText
                        )
                        .transition(.scale.combined(with: .opacity))
                }
            }
        }
        .disabled(inputValue <= 0)
        .sensoryFeedback(.impact(flexibility: .solid), trigger: showSuccess)
        .accessibilityLabel(showSuccess ? "Metric logged" : "Log metric")
    }

    // MARK: - Personal Records

    private var personalRecordsSection: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.sm) {
            Label("Personal Records", systemImage: "trophy.fill")
                .font(AppDesign.Typography.title3)
                .foregroundStyle(AppDesign.Colors.brightWhite)

            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible())],
                spacing: AppDesign.Spacing.sm
            ) {
                ForEach(JumpMetric.MetricType.allCases, id: \.self) { type in
                    PRCard(
                        type: type,
                        value: appState.progression.latestValue(for: type)
                    )
                }
            }
        }
    }

    // MARK: - Recent History

    private var recentHistorySection: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.sm) {
            Label("Recent History", systemImage: "clock.fill")
                .font(AppDesign.Typography.title3)
                .foregroundStyle(AppDesign.Colors.brightWhite)

            let recent = Array(appState.progression.metrics.prefix(10))

            if recent.isEmpty {
                emptyHistoryState
            } else {
                VStack(spacing: 0) {
                    ForEach(recent) { metric in
                        HistoryRow(metric: metric)
                        if metric.id != recent.last?.id {
                            Divider()
                                .background(AppDesign.Colors.surface3)
                                .padding(.leading, AppDesign.Spacing.xl + AppDesign.Spacing.sm)
                        }
                    }
                }
                .sportCard()
            }
        }
    }

    private var emptyHistoryState: some View {
        Text("No metrics logged yet. Start tracking your performance above.")
            .font(AppDesign.Typography.body)
            .foregroundStyle(AppDesign.Colors.mutedText)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .padding(AppDesign.Spacing.xl)
            .accessibilityLabel("No metrics logged yet. Start tracking your performance above.")
    }

    // MARK: - Actions

    private func selectType(_ type: JumpMetric.MetricType) -> () -> Void {
        {
            withAnimation(reduceMotion ? .none : AppDesign.Anim.fast) {
                selectedType = type
            }
            inputValue = 0
        }
    }

    private func logMetric() {
        guard inputValue > 0 else { return }
        let metric = JumpMetric(type: selectedType, value: inputValue)
        appState.progression.addMetric(metric)
        inputValue = 0
        withAnimation(reduceMotion ? .none : AppDesign.Anim.bounce) {
            showSuccess = true
        } completion: {
            withAnimation(reduceMotion ? .none : AppDesign.Anim.standard) {
                showSuccess = false
            }
        }
    }
}

// MARK: - TypeChip

private struct TypeChip: View {

    let type: JumpMetric.MetricType
    let isSelected: Bool
    let action: () -> Void

    private var accentColor: Color { accentColorFor(type.accentColor) }

    var body: some View {
        Button(type.rawValue, action: action)
            .font(AppDesign.Typography.label)
            .foregroundStyle(isSelected ? AppDesign.Colors.background : AppDesign.Colors.dimWhite)
            .padding(.horizontal, AppDesign.Spacing.md)
            .padding(.vertical, AppDesign.Spacing.sm)
            .background(isSelected ? accentColor : AppDesign.Colors.surface2)
            .clipShape(.capsule)
            .animation(AppDesign.Anim.fast, value: isSelected)
    }
}

// MARK: - PRCard

private struct PRCard: View {

    let type: JumpMetric.MetricType
    let value: Double?

    private var accentColor: Color { accentColorFor(type.accentColor) }

    var body: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.sm) {
            Image(systemName: type.iconName)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(accentColor)
                .accessibilityHidden(true)

            HStack(alignment: .firstTextBaseline, spacing: 3) {
                if let value {
                    Text(value, format: .number.precision(.fractionLength(1)))
                        .font(.system(size: 26, weight: .black, design: .rounded))
                        .foregroundStyle(AppDesign.Colors.brightWhite)
                    Text(type.unit)
                        .font(AppDesign.Typography.label)
                        .foregroundStyle(AppDesign.Colors.dimWhite)
                } else {
                    Text("—")
                        .font(.system(size: 26, weight: .black, design: .rounded))
                        .foregroundStyle(AppDesign.Colors.mutedText)
                }
            }

            Text(type.rawValue)
                .font(AppDesign.Typography.caption)
                .foregroundStyle(AppDesign.Colors.dimWhite)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .sportCard()
        .accessibilityElement(children: .combine)
        .accessibilityLabel(prAccessibilityLabel)
    }

    private var prAccessibilityLabel: String {
        if let value {
            "\(type.rawValue): \(value.formatted(.number.precision(.fractionLength(1)))) \(type.unit)"
        } else {
            "\(type.rawValue): no record yet"
        }
    }
}

// MARK: - HistoryRow

private struct HistoryRow: View {

    let metric: JumpMetric

    private var accentColor: Color { accentColorFor(metric.type.accentColor) }

    var body: some View {
        HStack(spacing: AppDesign.Spacing.sm) {
            Image(systemName: metric.type.iconName)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(accentColor)
                .frame(width: AppDesign.Spacing.xl, alignment: .center)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 2) {
                Text(metric.type.rawValue)
                    .font(AppDesign.Typography.label)
                    .foregroundStyle(AppDesign.Colors.brightWhite)
                Text(metric.date, format: .dateTime.month(.abbreviated).day().hour().minute())
                    .font(AppDesign.Typography.caption)
                    .foregroundStyle(AppDesign.Colors.mutedText)
            }

            Spacer()

            HStack(alignment: .firstTextBaseline, spacing: 3) {
                Text(metric.value, format: .number.precision(.fractionLength(1)))
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .foregroundStyle(AppDesign.Colors.brightWhite)
                Text(metric.unit)
                    .font(AppDesign.Typography.caption)
                    .foregroundStyle(AppDesign.Colors.dimWhite)
            }
        }
        .padding(.vertical, AppDesign.Spacing.sm)
        .padding(.horizontal, AppDesign.Spacing.md)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(
            "\(metric.type.rawValue), \(metric.value.formatted(.number.precision(.fractionLength(1)))) \(metric.unit), \(metric.date.formatted(date: .abbreviated, time: .shortened))"
        )
    }
}

// MARK: - Accent Color Helper

private func accentColorFor(_ key: String) -> Color {
    switch key {
    case "lime":   AppDesign.Colors.electricLime
    case "blue":   AppDesign.Colors.dynamicBlue
    case "orange": AppDesign.Colors.neonOrange
    case "cyan":   AppDesign.Colors.neonCyan
    default:       AppDesign.Colors.electricLime
    }
}

// MARK: - Preview

#Preview {
    JumpLoggerView()
        .environment(AppState(progress: UserProgress()))
        .environment(SubscriptionManagerBPV())
}
