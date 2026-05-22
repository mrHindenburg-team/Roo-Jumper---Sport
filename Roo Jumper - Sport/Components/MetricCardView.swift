import SwiftUI

struct MetricCardView: View {

    let metric: JumpMetric

    private var accentColor: Color {
        switch metric.type.accentColor {
        case "lime":   AppDesign.Colors.electricLime
        case "orange": AppDesign.Colors.neonOrange
        case "blue":   AppDesign.Colors.dynamicBlue
        case "cyan":   AppDesign.Colors.neonCyan
        default:       AppDesign.Colors.electricLime
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.sm) {
            HStack {
                Image(systemName: metric.type.iconName)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(accentColor)
                Spacer()
                Text(metric.date, format: .dateTime.month().day())
                    .font(AppDesign.Typography.caption)
                    .foregroundStyle(AppDesign.Colors.mutedText)
            }

            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(metric.value, format: .number.precision(.fractionLength(1)))
                    .font(.system(size: 28, weight: .black, design: .rounded))
                    .foregroundStyle(AppDesign.Colors.brightWhite)
                Text(metric.unit)
                    .font(AppDesign.Typography.label)
                    .foregroundStyle(AppDesign.Colors.dimWhite)
            }

            Text(metric.type.rawValue)
                .font(AppDesign.Typography.caption)
                .foregroundStyle(AppDesign.Colors.dimWhite)
        }
        .sportCard()
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(metric.type.rawValue): \(metric.value) \(metric.unit)")
    }
}

#Preview {
    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
        ForEach(TrainingDataStore.sampleMetrics) { metric in
            MetricCardView(metric: metric)
        }
    }
    .padding()
    .background(AppDesign.Colors.background)
}
