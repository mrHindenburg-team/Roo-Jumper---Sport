import SwiftUI

struct OnboardingInfoPageView: View {

    let title: String
    let subtitle: String
    let bodyString: String
    let iconName: String
    let accentColor: Color
    var stats: [(value: String, label: String)] = []
    var bullets: [(icon: String, text: String)] = []
    var footer: AnyView? = nil

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var iconScale = 0.6
    @State private var contentOpacity = 0.0

    var body: some View {
        ScrollView {
            VStack(spacing: AppDesign.Spacing.lg) {
                Spacer(minLength: 8)
                iconSection
                textSection
                if !stats.isEmpty { statsGrid }
                if !bullets.isEmpty { bulletsCard }
                if let footer { footer }
                Spacer(minLength: 8)
            }
            .padding(.horizontal, AppDesign.Spacing.xl)
        }
        .scrollIndicators(.hidden)
        .opacity(contentOpacity)
        .onAppear { animateIn() }
    }

    // MARK: - Sub-views

    private var iconSection: some View {
        ZStack {
            Circle()
                .fill(accentColor.opacity(0.12))
                .frame(width: 150, height: 150)
                .blur(radius: 28)
            Circle()
                .strokeBorder(accentColor.opacity(0.2), lineWidth: 1.5)
                .frame(width: 128, height: 128)
            Image(systemName: iconName)
                .font(.system(size: 54, weight: .bold))
                .foregroundStyle(
                    LinearGradient(
                        colors: [accentColor, accentColor.opacity(0.55)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .glowShadow(accentColor, radius: 22)
        }
        .scaleEffect(iconScale)
        .animation(reduceMotion ? .none : AppDesign.Anim.bounce.delay(0.1), value: iconScale)
    }

    private var textSection: some View {
        VStack(spacing: AppDesign.Spacing.sm) {
            Text(title)
                .font(AppDesign.Typography.headline)
                .foregroundStyle(AppDesign.Colors.brightWhite)
                .multilineTextAlignment(.center)
            Text(subtitle)
                .font(.system(size: 11, weight: .semibold, design: .rounded))
                .foregroundStyle(accentColor)
                .tracking(2)
                .multilineTextAlignment(.center)
            Text(bodyString)
                .font(AppDesign.Typography.body)
                .foregroundStyle(AppDesign.Colors.dimWhite)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .padding(.top, AppDesign.Spacing.xs)
        }
    }

    private var statsGrid: some View {
        HStack(spacing: AppDesign.Spacing.sm) {
            ForEach(0..<stats.count, id: \.self) { i in
                VStack(spacing: 2) {
                    Text(stats[i].value)
                        .font(.system(size: 24, weight: .black, design: .rounded))
                        .foregroundStyle(accentColor)
                    Text(stats[i].label)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundStyle(AppDesign.Colors.mutedText)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, AppDesign.Spacing.sm)
                .background(accentColor.opacity(0.08))
                .clipShape(.rect(cornerRadius: AppDesign.Radius.md))
            }
        }
    }

    private var bulletsCard: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.sm) {
            ForEach(0..<bullets.count, id: \.self) { i in
                HStack(alignment: .top, spacing: AppDesign.Spacing.sm) {
                    Image(systemName: bullets[i].icon)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(accentColor)
                        .frame(width: 22, alignment: .center)
                        .padding(.top, 2)
                    Text(bullets[i].text)
                        .font(AppDesign.Typography.body)
                        .foregroundStyle(AppDesign.Colors.dimWhite)
                        .lineSpacing(2)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(AppDesign.Spacing.md)
        .background(AppDesign.Colors.surface1)
        .clipShape(.rect(cornerRadius: AppDesign.Radius.lg))
        .overlay {
            RoundedRectangle(cornerRadius: AppDesign.Radius.lg)
                .strokeBorder(AppDesign.Colors.surface3, lineWidth: 1)
        }
    }

    // MARK: - Animation

    private func animateIn() {
        if reduceMotion { iconScale = 1; contentOpacity = 1; return }
        withAnimation(AppDesign.Anim.standard) { contentOpacity = 1 }
        withAnimation(AppDesign.Anim.bounce.delay(0.1)) { iconScale = 1.0 }
    }
}

#Preview {
    OnboardingInfoPageView(
        title: "The Training Engine",
        subtitle: "BUILT FOR EVERY LEVEL",
        bodyString: "41 exercises across 7 categories with coaching cues, muscle targets, and XP rewards.",
        iconName: "dumbbell.fill",
        accentColor: AppDesign.Colors.neonOrange,
        stats: [("41", "Exercises"), ("12", "Disciplines"), ("7", "Categories"), ("5", "Stages")],
        bullets: [
            ("bolt.fill", "Progressive plyometric protocols from beginner to elite"),
            ("figure.flexibility", "Mobility and recovery science built-in"),
        ]
    )
    .background(AppDesign.Colors.background)
}
