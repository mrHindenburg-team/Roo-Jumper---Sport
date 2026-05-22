import SwiftUI

struct ChatBubbleView: View {

    let message: AIMessage

    var body: some View {
        HStack(alignment: .top, spacing: AppDesign.Spacing.sm) {
            if message.role == .coach {
                coachAvatar
            }

            bubbleContent
                .frame(
                    maxWidth: .infinity,
                    alignment: message.role == .user ? .trailing : .leading
                )

            if message.role == .user {
                Spacer(minLength: 60)
            }
        }
        .padding(.horizontal, AppDesign.Spacing.sm)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(
            message.role == .user
            ? "You said: \(message.content)"
            : "Coach replied: \(message.content)"
        )
    }

    // MARK: - Sub-views

    private var coachAvatar: some View {
        VStack {
            Image(systemName: "brain.head.profile")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(AppDesign.Colors.neonCyan)
                .frame(width: 32, height: 32)
                .background(AppDesign.Colors.dynamicBlue.opacity(0.3))
                .clipShape(.circle)
            Spacer(minLength: 0)
        }
    }

    private var bubbleContent: some View {
        VStack(alignment: message.role == .user ? .trailing : .leading, spacing: 4) {
            Text(message.content)
                .font(AppDesign.Typography.body)
                .foregroundStyle(AppDesign.Colors.brightWhite)
                .padding(.horizontal, AppDesign.Spacing.md)
                .padding(.vertical, AppDesign.Spacing.sm)
                .background(bubbleBackground)
                .clipShape(.rect(cornerRadius: AppDesign.Radius.md))

            HStack(spacing: 4) {
                if message.isFromFallback {
                    Label("Offline Mode", systemImage: "externaldrive.fill")
                        .font(AppDesign.Typography.caption)
                        .foregroundStyle(AppDesign.Colors.neonOrange.opacity(0.7))
                }
                Text(message.timestamp, format: .dateTime.hour().minute())
                    .font(AppDesign.Typography.caption)
                    .foregroundStyle(AppDesign.Colors.mutedText)
            }
        }
    }

    @ViewBuilder
    private var bubbleBackground: some View {
        if message.role == .user {
            AppDesign.Colors.surface3
        } else {
            AppDesign.Colors.dynamicBlue.opacity(0.2)
        }
    }
}

#Preview {
    VStack(spacing: AppDesign.Spacing.sm) {
        ChatBubbleView(message: AIMessage(content: "How do I jump higher?", role: .user))
        ChatBubbleView(message: AIMessage(content: "Triple extension — ankle, knee, hip simultaneously. Add depth jumps and arm swing training to unlock 3–6 cm fast.", role: .coach))
    }
    .padding()
    .background(AppDesign.Colors.background)
}
