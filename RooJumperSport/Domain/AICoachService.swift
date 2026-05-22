import Foundation
import FoundationModels

// On-device AI coaching.
// iOS 26+: uses LanguageModelSession (Apple Intelligence).
// iOS 18–25: falls back entirely to SportsEducationEngine.
@Observable
@MainActor
final class AICoachService {

    // MARK: - State

    private(set) var isAIAvailable = false
    private(set) var isLoading = false

    /// Human-readable status label for display in the UI.
    var statusLabel: String {
        if isAIAvailable {
            return "Apple Intelligence · On-Device"
        }
        if #available(iOS 26, *) {
            return "AI Unavailable · Offline Education Mode"
        }
        return "Offline Education Mode (iOS 18–25)"
    }

    // MARK: - Private

    private let fallback = SportsEducationEngine()

    // Stored as Any so the property declaration itself needs no @available.
    // The typed accessor below is guarded with @available(iOS 26, *).
    private var _sessionBox: Any?

    private let systemInstructions = """
    You are an expert sports performance coach named "Roo" specialising in jumping \
    disciplines, plyometrics, and athletic explosiveness. Provide concise, evidence-based, \
    educational, and motivational training guidance. Focus areas: jump mechanics, plyometric \
    progressions, explosiveness development, body control, biomechanics, and injury \
    prevention. Keep answers clear and actionable. Never make medical diagnoses.
    """

    // MARK: - Init

    init() {
        Task { await setupSession() }
    }

    // MARK: - Typed session accessor (iOS 26+ only)

    @available(iOS 26, *)
    private var session: LanguageModelSession? {
        _sessionBox as? LanguageModelSession
    }

    // MARK: - Public API

    /// Returns (responseText, wasGeneratedByAI).
    func generateResponse(for prompt: String) async -> (text: String, isAI: Bool) {
        if #available(iOS 26, *), isAIAvailable, let session {
            isLoading = true
            defer { isLoading = false }
            do {
                let response = try await session.respond(to: prompt)
                return (response.content, true)
            } catch {
                return (fallback.generateResponse(for: prompt), false)
            }
        }
        return (fallback.generateResponse(for: prompt), false)
    }

    /// Streams tokens as they arrive. Falls back to a single-yield stream on older OS.
    func streamResponse(for prompt: String) -> AsyncStream<String> {
        if #available(iOS 26, *), isAIAvailable, let session {
            return makeAIStream(session: session, prompt: prompt)
        }
        return makeFallbackStream(for: prompt)
    }

    // MARK: - Private helpers

    @available(iOS 26, *)
    private func makeAIStream(session: LanguageModelSession, prompt: String) -> AsyncStream<String> {
        AsyncStream { continuation in
            Task {
                do {
                    for try await partial in session.streamResponse(to: prompt) {
                        continuation.yield(partial.content)
                    }
                } catch {
                    continuation.yield(self.fallback.generateResponse(for: prompt))
                }
                continuation.finish()
            }
        }
    }

    private func makeFallbackStream(for prompt: String) -> AsyncStream<String> {
        let text = fallback.generateResponse(for: prompt)
        return AsyncStream { continuation in
            continuation.yield(text)
            continuation.finish()
        }
    }

    private func setupSession() async {
        guard #available(iOS 26, *) else {
            // Below iOS 26 — always use the offline fallback engine.
            isAIAvailable = false
            return
        }

        let model = SystemLanguageModel.default
        guard model.isAvailable else {
            // iOS 26 device but Apple Intelligence not available (unsupported hardware,
            // not downloaded, or region restriction).
            isAIAvailable = false
            return
        }

        _sessionBox = LanguageModelSession(instructions: systemInstructions)
        isAIAvailable = true
    }
}
