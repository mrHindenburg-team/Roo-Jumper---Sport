import SwiftUI

struct GlowingProgressBar: View {

    let value: Double          // 0.0 – 1.0
    let accentColor: Color
    var height: CGFloat = 8
    var showLabel = false
    var labelText: String = ""

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var animatedValue: Double = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if showLabel {
                HStack {
                    Text(labelText)
                        .font(AppDesign.Typography.caption)
                        .foregroundStyle(AppDesign.Colors.dimWhite)
                    Spacer()
                    Text("\(Int(animatedValue * 100))%")
                        .font(AppDesign.Typography.caption)
                        .foregroundStyle(accentColor)
                }
            }
            progressTrack
        }
        .onAppear { animate() }
        .onChange(of: value) { animate() }
        .accessibilityValue("\(Int(value * 100)) percent")
    }

    private var progressTrack: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .fill(AppDesign.Colors.surface3)
                .frame(height: height)

            Capsule()
                .fill(
                    LinearGradient(
                        colors: [accentColor, accentColor.opacity(0.7)],
                        startPoint: .leading, endPoint: .trailing
                    )
                )
                .frame(height: height)
                .scaleEffect(x: animatedValue, anchor: .leading)
                .shadow(color: accentColor.opacity(0.6), radius: 6, x: 0, y: 0)
        }
    }

    private func animate() {
        if reduceMotion {
            animatedValue = value
            return
        }
        withAnimation(AppDesign.Anim.slow) {
            animatedValue = max(0, min(1, value))
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        GlowingProgressBar(value: 0.65, accentColor: AppDesign.Colors.electricLime, showLabel: true, labelText: "Level Progress")
        GlowingProgressBar(value: 0.40, accentColor: AppDesign.Colors.neonOrange, showLabel: true, labelText: "Evolution")
        GlowingProgressBar(value: 0.85, accentColor: AppDesign.Colors.dynamicBlue, showLabel: true, labelText: "Weekly Goal")
    }
    .padding()
    .background(AppDesign.Colors.surface1)
}
