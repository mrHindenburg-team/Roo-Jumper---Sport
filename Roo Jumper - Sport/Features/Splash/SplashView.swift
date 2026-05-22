import SwiftUI

struct SplashView: View {

    @Binding var isVisible: Bool
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var logoScale: Double = 0.3
    @State private var logoOpacity: Double = 0.0
    @State private var taglineOpacity: Double = 0.0
    @State private var particleOpacity: Double = 0.0
    @State private var glowIntensity: Double = 0.0

    var body: some View {
        ZStack {
            backgroundLayer
            particleLayer
            contentLayer
        }
        .ignoresSafeArea()
        .task { await runSplashSequence() }
    }

    // MARK: - Sub-views

    private var backgroundLayer: some View {
        AppDesign.Colors.background
            .overlay {
                RadialGradient(
                    colors: [
                        AppDesign.Colors.electricLime.opacity(0.08),
                        AppDesign.Colors.background
                    ],
                    center: .center,
                    startRadius: 80,
                    endRadius: 400
                )
            }
    }

    private var particleLayer: some View {
        ZStack {
            ForEach(0..<20, id: \.self) { i in
                SplashParticle(index: i)
            }
        }
        .opacity(particleOpacity)
    }

    private var contentLayer: some View {
        VStack(spacing: AppDesign.Spacing.lg) {
            Spacer()
            logoMark
            wordmark
            taglineText
            Spacer()
            bottomLabel
        }
    }

    private var logoMark: some View {
        ZStack {
            Circle()
                .fill(AppDesign.Colors.electricLime.opacity(0.12))
                .frame(width: 140, height: 140)
                .blur(radius: 24)

            Image(systemName: "figure.gymnastics")
                .font(.system(size: 72, weight: .black))
                .foregroundStyle(AppDesign.Colors.explosiveness)
                .shadow(color: AppDesign.Colors.electricLime.opacity(glowIntensity), radius: 24)
        }
        .scaleEffect(logoScale)
        .opacity(logoOpacity)
    }

    private var wordmark: some View {
        VStack(spacing: AppDesign.Spacing.xs) {
            Text("ROO JUMPER")
                .font(.system(size: 36, weight: .black, design: .rounded))
                .foregroundStyle(AppDesign.Colors.brightWhite)
                .tracking(6)
            Text("SPORT")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundStyle(AppDesign.Colors.electricLime)
                .tracking(12)
        }
        .opacity(logoOpacity)
    }

    private var taglineText: some View {
        Text("Master the Art of Jumping")
            .font(AppDesign.Typography.label)
            .foregroundStyle(AppDesign.Colors.dimWhite)
            .tracking(2)
            .opacity(taglineOpacity)
    }

    private var bottomLabel: some View {
        Text("Powered by On-Device AI")
            .font(AppDesign.Typography.caption)
            .foregroundStyle(AppDesign.Colors.mutedText)
            .padding(.bottom, AppDesign.Spacing.xl)
            .opacity(taglineOpacity)
    }

    // MARK: - Animation Sequence

    private func runSplashSequence() async {
        if reduceMotion {
            logoScale = 1
            logoOpacity = 1
            taglineOpacity = 1
            particleOpacity = 1
            glowIntensity = 0.7
            try? await Task.sleep(for: .seconds(1.5))
            withAnimation(AppDesign.Anim.standard) { isVisible = false }
            return
        }

        try? await Task.sleep(for: .milliseconds(200))

        withAnimation(AppDesign.Anim.energetic) {
            logoScale = 1.1
            logoOpacity = 1
        }
        try? await Task.sleep(for: .milliseconds(350))

        withAnimation(AppDesign.Anim.bounce) {
            logoScale = 1.0
            glowIntensity = 0.8
        }
        try? await Task.sleep(for: .milliseconds(200))

        withAnimation(AppDesign.Anim.standard) {
            taglineOpacity = 1
            particleOpacity = 1
        }
        try? await Task.sleep(for: .seconds(1.6))

        withAnimation(AppDesign.Anim.cinematic) {
            logoOpacity = 0
            taglineOpacity = 0
            particleOpacity = 0
        }
        try? await Task.sleep(for: .milliseconds(900))
        withAnimation(AppDesign.Anim.standard) {
            isVisible = false
        }
    }
}

// MARK: - SplashParticle

private struct SplashParticle: View {

    let index: Int
    @State private var offset = CGSize.zero
    @State private var opacity: Double = 0

    var body: some View {
        Circle()
            .fill(particleColor)
            .frame(width: size, height: size)
            .blur(radius: size * 0.3)
            .offset(offset)
            .opacity(opacity)
            .onAppear { animateParticle() }
    }

    private var particleColor: Color {
        index % 3 == 0 ? AppDesign.Colors.electricLime :
        index % 3 == 1 ? AppDesign.Colors.dynamicBlue :
                         AppDesign.Colors.neonOrange
    }

    private var size: CGFloat { CGFloat(4 + (index % 5) * 3) }

    private var startX: CGFloat { CGFloat.random(in: -180...180) }
    private var startY: CGFloat { CGFloat.random(in: -350...350) }

    private func animateParticle() {
        let delay = Double(index) * 0.06
        offset = CGSize(width: startX, height: startY)
        withAnimation(
            .easeInOut(duration: 1.8).delay(delay).repeatForever(autoreverses: true)
        ) {
            offset = CGSize(width: startX + CGFloat.random(in: -40...40),
                           height: startY + CGFloat.random(in: -60...60))
            opacity = Double.random(in: 0.3...0.8)
        }
    }
}

#Preview {
    SplashView(isVisible: .constant(true))
}
