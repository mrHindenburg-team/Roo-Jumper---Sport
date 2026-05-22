import SwiftUI

// Animated preview of the AI coach shown on the Home screen.
struct AICoachPreviewCard: View {

    @Environment(AppState.self) private var appState
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var currentMessageIndex = 0
    @State private var displayedText = ""
    @State private var isTyping = false
    @State private var glowPulse = false

    private let sampleExchanges: [(user: String, coach: String)] = [
        (
            "How do I jump higher?",
            "Triple extension — ankle, knee, hip — simultaneously. Add depth jumps and arm swing training to unlock 3–6 cm fast."
        ),
        (
            "What muscles matter most?",
            "Glutes generate the primary force. Calves return elastic energy. Build both with single-leg work and weighted calf raises."
        ),
        (
            "How does plyometric training work?",
            "The stretch-shortening cycle stores elastic energy in tendons during landing. Plyometrics train you to release it faster."
        ),
        (
            "How do I improve landing safely?",
            "Soft landings: toes first, knees bent to 90°, hips back. 'Quiet landing' training reduces ACL risk by 50%."
        )
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            cardHeader
            Divider()
                .background(AppDesign.Colors.surface3)
            conversationBody
                .padding(AppDesign.Spacing.md)
        }
        .background(AppDesign.Colors.aiCoach)
        .clipShape(.rect(cornerRadius: AppDesign.Radius.xl))
        .overlay {
            RoundedRectangle(cornerRadius: AppDesign.Radius.xl)
                .strokeBorder(
                    AppDesign.Colors.dynamicBlue.opacity(glowPulse ? 0.7 : 0.3),
                    lineWidth: 1.5
                )
        }
        .shadow(color: AppDesign.Colors.dynamicBlue.opacity(0.3), radius: 20, x: 0, y: 8)
        .task { try? await runConversationLoop() }
    }

    // MARK: - Sub-views

    private var cardHeader: some View {
        HStack(spacing: AppDesign.Spacing.sm) {
            ZStack {
                Circle()
                    .fill(AppDesign.Colors.dynamicBlue.opacity(0.25))
                    .frame(width: 40, height: 40)
                Image(systemName: "brain.head.profile")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(AppDesign.Colors.neonCyan)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text("Roo AI Coach")
                    .font(AppDesign.Typography.label)
                    .foregroundStyle(AppDesign.Colors.brightWhite)
                HStack(spacing: 4) {
                    Circle()
                        .fill(AppDesign.Colors.electricLime)
                        .frame(width: 6, height: 6)
                        .opacity(glowPulse ? 1.0 : 0.5)
                        .animation(
                            reduceMotion ? .none : .easeInOut(duration: 0.9).repeatForever(autoreverses: true),
                            value: glowPulse
                        )
                    Text("On-Device · Offline")
                        .font(AppDesign.Typography.caption)
                        .foregroundStyle(AppDesign.Colors.dimWhite)
                }
            }
            Spacer()
            Image(systemName: appState.aiCoach.isAIAvailable ? "checkmark.seal.fill" : "externaldrive.fill")
                .font(.system(size: 14))
                .foregroundStyle(
                    appState.aiCoach.isAIAvailable ? AppDesign.Colors.electricLime : AppDesign.Colors.neonOrange
                )
        }
        .padding(AppDesign.Spacing.md)
    }

    private var conversationBody: some View {
        let exchange = sampleExchanges[currentMessageIndex]
        return VStack(alignment: .leading, spacing: AppDesign.Spacing.sm) {
            userBubble(text: exchange.user)
            if !displayedText.isEmpty || isTyping {
                coachBubble(text: displayedText, typing: isTyping)
            }
        }
    }

    private func userBubble(text: String) -> some View {
        HStack {
            Spacer()
            Text(text)
                .font(AppDesign.Typography.caption)
                .foregroundStyle(AppDesign.Colors.brightWhite)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(AppDesign.Colors.surface3)
                .clipShape(.rect(cornerRadius: 14))
        }
    }

    private func coachBubble(text: String, typing: Bool) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "brain.head.profile")
                .font(.system(size: 12))
                .foregroundStyle(AppDesign.Colors.neonCyan)
                .padding(6)
                .background(AppDesign.Colors.dynamicBlue.opacity(0.3))
                .clipShape(.circle)

            Group {
                if typing && text.isEmpty {
                    TypingIndicator()
                } else {
                    Text(text)
                        .font(AppDesign.Typography.caption)
                        .foregroundStyle(AppDesign.Colors.brightWhite)
                        .lineSpacing(3)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(AppDesign.Colors.dynamicBlue.opacity(0.25))
            .clipShape(.rect(cornerRadius: 14))
            Spacer()
        }
    }

    // MARK: - Animation Loop

    private func runConversationLoop() async throws {
        glowPulse = true

        while true {
            let exchange = sampleExchanges[currentMessageIndex]
            displayedText = ""
            isTyping = true

            try await Task.sleep(for: .milliseconds(600))

            if !reduceMotion {
                try await typeText(exchange.coach)
            } else {
                displayedText = exchange.coach
            }
            isTyping = false

            try await Task.sleep(for: .seconds(3.5))

            withAnimation(AppDesign.Anim.standard) {
                displayedText = ""
                currentMessageIndex = (currentMessageIndex + 1) % sampleExchanges.count
            }
            try await Task.sleep(for: .milliseconds(400))
        }
    }

    private func typeText(_ text: String) async throws {
        for character in text {
            displayedText.append(character)
            try await Task.sleep(for: .milliseconds(18))
        }
    }
}

// MARK: - TypingIndicator

private struct TypingIndicator: View {
    @State private var activeDot = 0

    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<3, id: \.self) { i in
                Circle()
                    .fill(AppDesign.Colors.neonCyan)
                    .frame(width: 5, height: 5)
                    .opacity(activeDot == i ? 1.0 : 0.3)
                    .scaleEffect(activeDot == i ? 1.3 : 1.0)
                    .animation(AppDesign.Anim.fast, value: activeDot)
            }
        }
        .task {
            do {
                while true {
                    try await Task.sleep(for: .milliseconds(380))
                    activeDot = (activeDot + 1) % 3
                }
            } catch {}
        }
    }
}

#Preview {
    AICoachPreviewCard()
        .padding()
        .background(AppDesign.Colors.background)
        .environment(AppState(progress: UserProgress()))
}
