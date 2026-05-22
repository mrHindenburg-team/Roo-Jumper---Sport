import SwiftUI

@Observable
@MainActor
final class HomeViewModel {

    // MARK: - State

    var greeting: String = ""
    var dailyChallengeTitle = "Today's Challenge"
    var dailyChallengeDescription = "Complete 4 sets of Box Jumps — maximum effort"
    var dailyChallengeXP = 120
    var isDailyChallengeCompleted = false
    var motivationalQuote = ""

    // MARK: - Init

    init() {
        greeting = makeGreeting()
        motivationalQuote = quotes.randomElement() ?? ""
        let challenge = todaysChallenge()
        dailyChallengeTitle = challenge.title
        dailyChallengeDescription = challenge.description
        dailyChallengeXP = challenge.xp
    }

    // MARK: - Actions

    func completeDailyChallenge() {
        withAnimation(AppDesign.Anim.bounce) {
            isDailyChallengeCompleted = true
        }
    }

    // MARK: - Private

    private func makeGreeting() -> String {
        let hour = Calendar.current.component(.hour, from: Date.now)
        return switch hour {
        case 5..<12:  "Good Morning, Athlete"
        case 12..<17: "Good Afternoon, Athlete"
        case 17..<21: "Good Evening, Athlete"
        default:      "Night Session Active"
        }
    }

    private func todaysChallenge() -> (title: String, description: String, xp: Int) {
        let day = Calendar.current.ordinality(of: .day, in: .year, for: Date.now) ?? 1
        return challengeList[(day - 1) % challengeList.count]
    }

    private let challengeList: [(title: String, description: String, xp: Int)] = [
        ("Box Jump Blast",         "5×5 max-height box jumps — full arm swing every rep",             120),
        ("Depth Jump Circuit",     "3×8 depth jumps from a 40 cm platform — explode up each time",   140),
        ("Single-Leg Power Hops",  "4×10 per leg — explosive push-off, stick each landing",           100),
        ("Broad Jump Power",       "5×3 standing broad jumps — max distance, measure your best",      130),
        ("Ankle Elasticity Drill", "100 rapid double-leg hops in under 20 seconds — stay on toes",    90),
        ("Triple Extension Drill", "5×5 hang power cleans or trap-bar deadlift jumps",                150),
        ("Reactive Sprint",        "6×20 m sprint from a standing start — all-out acceleration",      110),
        ("Tuck Jump Tabata",       "8 rounds: 20 s max tuck jumps / 10 s rest",                       130),
        ("Skater Jumps",           "4×12 lateral jumps — land and hold for 1 second each side",       100),
        ("Loaded Pause Squat",     "4×5 pause squats at 60 % 1RM — 2 s pause, explosive up",         120),
        ("Plyometric Circuit",     "Box jump → broad jump → tuck jump × 4 rounds, no rest between",  160),
        ("Max Vertical Test",      "Full warm-up, then 3 attempts — track your personal best",         80),
        ("Sprint Ladder",          "10 m → 20 m → 30 m → 20 m → 10 m — 90 s rest each",             140),
        ("Quiet Landing Drill",    "3×10 drop landings — silent, controlled, knees over toes",         80),
        ("Wall-Drive Explosiveness","4×8 wall-drive sprints — drive knee to chest in one powerful burst", 110),
    ]

    private let quotes = [
        "Champions are built in the moments they want to quit.",
        "Every jump is a conversation with gravity. Win the argument.",
        "Explosiveness is not a gift. It is a decision.",
        "Your vertical is a result of your habits.",
        "The ground is temporary. The air is where legends live.",
        "One more set separates you from the athlete you want to be.",
        "Plyometrics don't care about your feelings. Train anyway.",
        "Height is temporary. Work ethic is permanent.",
        "Your best jump hasn't happened yet.",
        "Pain is temporary. Peak performance is earned forever."
    ]
}
