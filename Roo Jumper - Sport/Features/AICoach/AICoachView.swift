import SwiftUI
import SwiftData

struct AICoachView: View {

    @Environment(AppState.self) private var appState
    @Environment(SubscriptionManagerBPV.self) private var purchaseManager
    @Environment(\.modelContext) private var modelContext

    @State private var viewModel: AICoachViewModel?
    @State private var scrollProxy: ScrollViewProxy?
    @State private var showOnDeviceAlert = false
    @State private var isRecording = false

    private var isPremium: Bool {
        purchaseManager.isPurchased(.eliteExplosivenessPack)
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                AppDesign.Colors.background.ignoresSafeArea()

                VStack(spacing: 0) {
                    aiStatusBar
                    chatScrollView
                    if let vm = viewModel {
                        FreeLimitBanner(vm: vm, isPremium: isPremium)
                        inputBar(vm: vm)
                    }
                }
            }
            .navigationTitle("AI Coach")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { toolbarItems }
        }
        .task {
            let vm = AICoachViewModel(appState: appState, modelContext: modelContext)
            viewModel = vm
            if !appState.progression.userProgress.hasSeenAIDisclaimer {
                showOnDeviceAlert = true
                appState.progression.userProgress.hasSeenAIDisclaimer = true
                try? modelContext.save()
            }
        }
        .overlay {
            if showOnDeviceAlert {
                AIOnDeviceAlertView(isPresented: $showOnDeviceAlert)
                    .transition(.opacity.combined(with: .scale(scale: 0.95)))
            }
        }
        .animation(AppDesign.Anim.standard, value: showOnDeviceAlert)
    }

    // MARK: - AI Status Bar

    private var aiStatusBar: some View {
        HStack(spacing: AppDesign.Spacing.sm) {
            Circle()
                .fill(appState.aiCoach.isAIAvailable ? AppDesign.Colors.electricLime : AppDesign.Colors.neonOrange)
                .frame(width: 8, height: 8)
            Text(appState.aiCoach.statusLabel)
                .font(AppDesign.Typography.caption)
                .foregroundStyle(AppDesign.Colors.dimWhite)
            Spacer()
            if !isPremium {
                Text("\(appState.progression.aiMessagesRemaining) free left")
                    .font(AppDesign.Typography.caption)
                    .foregroundStyle(
                        appState.progression.aiMessagesRemaining <= 1
                        ? AppDesign.Colors.neonOrange
                        : AppDesign.Colors.mutedText
                    )
            }
        }
        .padding(.horizontal, AppDesign.Spacing.md)
        .padding(.vertical, AppDesign.Spacing.sm)
        .background(AppDesign.Colors.surface1)
    }

    // MARK: - Chat

    private var chatScrollView: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: AppDesign.Spacing.md) {
                    if let vm = viewModel {
                        ForEach(vm.messages) { message in
                            ChatBubbleView(message: message)
                                .id(message.id)
                        }
                        if vm.isGenerating {
                            GeneratingIndicator()
                        }
                    }
                }
                .padding(.vertical, AppDesign.Spacing.md)
            }
            .scrollIndicators(.hidden)
            .onChange(of: viewModel?.messages.count) {
                if let id = viewModel?.messages.last?.id {
                    withAnimation(AppDesign.Anim.standard) {
                        proxy.scrollTo(id, anchor: .bottom)
                    }
                }
            }
        }
    }

    // MARK: - Input Bar

    private func inputBar(vm: AICoachViewModel) -> some View {
        HStack(spacing: AppDesign.Spacing.sm) {
            TextField(
                "Ask me about jumping, training, biomechanics...",
                text: Bindable(vm).inputText,
                axis: .vertical
            )
            .lineLimit(1...4)
            .font(AppDesign.Typography.body)
            .foregroundStyle(AppDesign.Colors.brightWhite)
            .padding(.horizontal, AppDesign.Spacing.md)
            .padding(.vertical, AppDesign.Spacing.sm)
            .background(AppDesign.Colors.surface2)
            .clipShape(.rect(cornerRadius: AppDesign.Radius.full))

            Button(action: { Task { await vm.sendMessage(isPremium: isPremium) } }) {
                Image(systemName: vm.isGenerating ? "stop.circle.fill" : "arrow.up.circle.fill")
                    .font(.system(size: 36))
                    .foregroundStyle(
                        vm.canSendMessage
                        ? AppDesign.Colors.electricLime
                        : AppDesign.Colors.mutedText
                    )
            }
            .disabled(!vm.canSendMessage && !vm.isGenerating)
            .accessibilityLabel("Send message")
            .sensoryFeedback(.impact(flexibility: .soft), trigger: vm.messages.count)
        }
        .padding(AppDesign.Spacing.md)
        .background(AppDesign.Colors.surface1)
        .overlay(alignment: .top) {
            Rectangle()
                .fill(AppDesign.Colors.surface3)
                .frame(height: 1)
        }
    }

    // MARK: - Toolbar

    @ToolbarContentBuilder
    private var toolbarItems: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            if let vm = viewModel {
                Button("Clear", action: vm.clearChat)
                    .font(AppDesign.Typography.label)
                    .foregroundStyle(AppDesign.Colors.dimWhite)
            }
        }
        ToolbarItem(placement: .topBarLeading) {
            Button("About AI", action: { showOnDeviceAlert = true })
                .font(AppDesign.Typography.label)
                .foregroundStyle(AppDesign.Colors.dynamicBlue)
        }
    }
}

// MARK: - Generating Indicator

private struct GeneratingIndicator: View {
    @State private var activeDot = 0

    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<3, id: \.self) { i in
                Circle()
                    .fill(AppDesign.Colors.dynamicBlue)
                    .frame(width: 7, height: 7)
                    .scaleEffect(activeDot == i ? 1.3 : 0.8)
                    .animation(AppDesign.Anim.fast.delay(Double(i) * 0.12), value: activeDot)
            }
        }
        .padding(.horizontal, AppDesign.Spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .task {
            do {
                while true {
                    try await Task.sleep(for: .milliseconds(350))
                    activeDot = (activeDot + 1) % 3
                }
            } catch {}
        }
        .accessibilityLabel("Coach is thinking")
    }
}

// MARK: - Free Limit Banner

private struct FreeLimitBanner: View {
    let vm: AICoachViewModel
    let isPremium: Bool

    var body: some View {
        if vm.showFreeLimit && !isPremium {
            HStack(spacing: AppDesign.Spacing.sm) {
                Image(systemName: "lock.fill")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(AppDesign.Colors.neonOrange)
                Text("Free limit reached — simplified answers active. Upgrade for unlimited AI.")
                    .font(AppDesign.Typography.caption)
                    .foregroundStyle(AppDesign.Colors.dimWhite)
            }
            .padding(AppDesign.Spacing.sm)
            .frame(maxWidth: .infinity)
            .background(AppDesign.Colors.neonOrange.opacity(0.1))
            .overlay(alignment: .top) {
                Rectangle()
                    .fill(AppDesign.Colors.neonOrange.opacity(0.4))
                    .frame(height: 1)
            }
        }
    }
}

#Preview {
    AICoachView()
        .environment(AppState(progress: UserProgress()))
        .environment(SubscriptionManagerBPV())
}
