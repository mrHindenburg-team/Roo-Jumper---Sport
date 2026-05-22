import SwiftUI

// Fully custom on-device AI disclaimer alert — matches the energetic sports aesthetic.
struct AIOnDeviceAlertView: View {

    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
                .onTapGesture { dismiss() }

            alertCard
        }
    }

    private var alertCard: some View {
        VStack(spacing: AppDesign.Spacing.lg) {
            alertIcon
            alertTitle
            alertBody
            divider
            dismissButton
        }
        .padding(AppDesign.Spacing.xl)
        .background(AppDesign.Colors.surface1)
        .clipShape(.rect(cornerRadius: AppDesign.Radius.xl))
        .overlay {
            RoundedRectangle(cornerRadius: AppDesign.Radius.xl)
                .strokeBorder(AppDesign.Colors.dynamicBlue.opacity(0.5), lineWidth: 1.5)
        }
        .shadow(color: AppDesign.Colors.dynamicBlue.opacity(0.4), radius: 30, x: 0, y: 10)
        .padding(.horizontal, AppDesign.Spacing.xl)
    }

    private var alertIcon: some View {
        ZStack {
            Circle()
                .fill(AppDesign.Colors.dynamicBlue.opacity(0.15))
                .frame(width: 80, height: 80)
            Image(systemName: "brain.head.profile")
                .font(.system(size: 36, weight: .semibold))
                .foregroundStyle(
                    LinearGradient(
                        colors: [AppDesign.Colors.dynamicBlue, AppDesign.Colors.neonCyan],
                        startPoint: .topLeading, endPoint: .bottomTrailing
                    )
                )
        }
    }

    private var alertTitle: some View {
        Text("AI Coach runs on your device")
            .font(AppDesign.Typography.title)
            .foregroundStyle(AppDesign.Colors.brightWhite)
            .multilineTextAlignment(.center)
    }

    private var alertBody: some View {
        VStack(spacing: AppDesign.Spacing.sm) {
            infoRow(icon: "lock.fill",                  text: "No data is sent to servers. Everything is private.",                                       color: AppDesign.Colors.electricLime)
            infoRow(icon: "wifi.slash",                 text: "Works in airplane mode. Fully offline.",                                                   color: AppDesign.Colors.electricLime)
            infoRow(icon: "cpu.fill",                   text: "Powered by Apple Intelligence — requires iOS 26 and a supported device.",                  color: AppDesign.Colors.dynamicBlue)
            infoRow(icon: "arrow.down.circle.fill",     text: "On older devices or iOS < 26, a structured offline education engine is used instead.",     color: AppDesign.Colors.dynamicBlue)
            infoRow(icon: "exclamationmark.triangle.fill", text: "On-device AI may be less detailed than cloud-based AI systems.",                        color: AppDesign.Colors.neonOrange)
            infoRow(icon: "bolt.fill",                  text: "Free: 5 AI-generated responses per session. Premium: unlimited.",                          color: AppDesign.Colors.neonOrange)
        }
    }

    private func infoRow(icon: String, text: String, color: Color) -> some View {
        HStack(alignment: .top, spacing: AppDesign.Spacing.sm) {
            Image(systemName: icon)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(color)
                .frame(width: 20)
            Text(text)
                .font(AppDesign.Typography.body)
                .foregroundStyle(AppDesign.Colors.dimWhite)
                .multilineTextAlignment(.leading)
            Spacer()
        }
    }

    private var divider: some View {
        Rectangle()
            .fill(AppDesign.Colors.surface3)
            .frame(height: 1)
    }

    private var dismissButton: some View {
        Button("Got it — Let's Train", action: dismiss)
            .font(AppDesign.Typography.title3)
            .foregroundStyle(AppDesign.Colors.background)
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppDesign.Spacing.md)
            .background(AppDesign.Colors.explosiveness)
            .clipShape(.rect(cornerRadius: AppDesign.Radius.full))
    }

    private func dismiss() {
        withAnimation(AppDesign.Anim.standard) {
            isPresented = false
        }
    }
}

#Preview {
    AIOnDeviceAlertView(isPresented: .constant(true))
}
