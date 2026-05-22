import SwiftUI
import SwiftData

@Observable
@MainActor
final class AICoachViewModel {

    // MARK: - State

    var messages: [AIMessage] = []
    var inputText = ""
    var isGenerating = false
    var streamingText = ""
    var showOnDeviceAlert = false
    var showFreeLimit = false

    // MARK: - Private

    private let appState: AppState
    private let modelContext: ModelContext

    // MARK: - Init

    init(appState: AppState, modelContext: ModelContext) {
        self.appState     = appState
        self.modelContext = modelContext
        addWelcomeMessage()
    }

    // MARK: - Public API

    var canSendMessage: Bool {
        !inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !isGenerating
    }

    var isFreeUser: Bool {
        // Free if neither premium pack is purchased
        true // Will be overridden in the view using purchaseManager
    }

    func sendMessage(isPremium: Bool) async {
        let text = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }

        let isOverLimit = !isPremium && appState.progression.userProgress.aiMessagesUsedThisSession >= AppConstants.aiFreeTierLimit

        // Always add the user message
        let userMessage = AIMessage(content: text, role: .user)
        withAnimation(AppDesign.Anim.standard) {
            messages.append(userMessage)
        }
        inputText = ""
        isGenerating = true

        // If over free limit, use fallback only
        let useFallback = isOverLimit
        if isOverLimit {
            showFreeLimit = true
        }

        if useFallback {
            let engine = SportsEducationEngine()
            let response = engine.generateResponse(for: text)
            try? await Task.sleep(for: .milliseconds(AppConstants.fallbackResponseDelayMs))
            let coachMsg = AIMessage(content: response, role: .coach, isFromFallback: true)
            withAnimation(AppDesign.Anim.standard) {
                messages.append(coachMsg)
            }
        } else {
            // Use streaming AI response
            streamingText = ""
            let placeholder = AIMessage(content: "", role: .coach)
            withAnimation(AppDesign.Anim.standard) { messages.append(placeholder) }

            var fullText = ""
            let stream = appState.aiCoach.streamResponse(for: text)
            for await chunk in stream {
                fullText = chunk
                streamingText = chunk
                if let lastIndex = messages.indices.last {
                    messages[lastIndex].content = fullText
                    messages[lastIndex].isFromFallback = !appState.aiCoach.isAIAvailable
                }
            }
            streamingText = ""

            appState.progression.recordAIMessage(context: modelContext)
        }

        isGenerating = false
    }

    func clearChat() {
        withAnimation(AppDesign.Anim.standard) {
            messages.removeAll()
        }
        addWelcomeMessage()
        appState.progression.resetAISession(context: modelContext)
        showFreeLimit = false
    }

    // MARK: - Private

    private func addWelcomeMessage() {
        let welcome = AIMessage(
            content: """
            Hi! I'm Roo, your on-device AI sports performance coach. 🏋️

            Ask me anything about jumping, explosiveness, plyometrics, high jump technique, parkour, basketball vertical — or any sport involving explosive movement.

            I run entirely on your device — no internet, no data sent anywhere.
            """,
            role: .coach,
            isFromFallback: !appState.aiCoach.isAIAvailable
        )
        messages.append(welcome)
    }
}
