import SwiftUI

struct OnboardingView: View {

    @Binding var hasSeenOnboarding: Bool
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var currentPage = 0
    @State private var selectedSports: Set<String> = []
    @State private var selectedLevel: String? = nil

    private let totalPages = 7

    var body: some View {
        ZStack(alignment: .bottom) {
            AppDesign.Colors.background.ignoresSafeArea()

            VStack(spacing: 0) {
                skipButton
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, AppDesign.Spacing.md)

                TabView(selection: $currentPage) {
                    welcomePage.tag(0)
                    sportSelectorPage.tag(1)
                    levelSelectorPage.tag(2)
                    trainingEnginePage.tag(3)
                    aiCoachPage.tag(4)
                    progressionPage.tag(5)
                    readyPage.tag(6)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(reduceMotion ? .none : AppDesign.Anim.standard, value: currentPage)

                bottomControls
                    .padding(.bottom, AppDesign.Spacing.xxxl)
                    .padding(.horizontal, AppDesign.Spacing.xl)
            }
        }
    }

    // MARK: - Page 0: Welcome

    private var welcomePage: some View {
        OnboardingInfoPageView(
            title: "Roo Jumper — Sport",
            subtitle: "MASTER EXPLOSIVE MOVEMENT",
            bodyString: "Your complete offline training system for jumping power, biomechanics, and athletic development. 12 sport disciplines. 41 exercises. Unlimited potential.",
            iconName: "figure.gymnastics",
            accentColor: AppDesign.Colors.electricLime,
            footer: AnyView(welcomeStatChips)
        )
    }

    private var welcomeStatChips: some View {
        HStack(spacing: AppDesign.Spacing.sm) {
            miniStatChip("41", "Exercises", AppDesign.Colors.electricLime)
            miniStatChip("12", "Disciplines", AppDesign.Colors.dynamicBlue)
            miniStatChip("AI", "On-Device", AppDesign.Colors.neonCyan)
        }
        .padding(.top, AppDesign.Spacing.sm)
    }

    // MARK: - Page 1: Sport Focus

    private var sportSelectorPage: some View {
        VStack(spacing: 0) {
            Spacer(minLength: AppDesign.Spacing.md)

            VStack(spacing: AppDesign.Spacing.sm) {
                Text("Your Focus Sport")
                    .font(AppDesign.Typography.headline)
                    .foregroundStyle(AppDesign.Colors.brightWhite)
                Text("SELECT ALL THAT APPLY")
                    .font(.system(size: 11, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppDesign.Colors.electricLime)
                    .tracking(2)
            }
            .padding(.bottom, AppDesign.Spacing.lg)

            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())],
                spacing: AppDesign.Spacing.sm
            ) {
                ForEach(OnboardingData.sports) { sport in
                    SportChip(
                        sport: sport,
                        isSelected: selectedSports.contains(sport.id)
                    ) { toggleSport(sport.id) }
                }
            }
            .padding(.horizontal, AppDesign.Spacing.md)

            Group {
                if selectedSports.isEmpty {
                    Text("You can skip this — training works for every athlete")
                        .font(AppDesign.Typography.caption)
                        .foregroundStyle(AppDesign.Colors.mutedText)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, AppDesign.Spacing.xl)
                } else {
                    Text("\(selectedSports.count) sport\(selectedSports.count == 1 ? "" : "s") selected")
                        .font(AppDesign.Typography.caption)
                        .foregroundStyle(AppDesign.Colors.electricLime)
                }
            }
            .padding(.top, AppDesign.Spacing.md)

            Spacer(minLength: AppDesign.Spacing.md)
        }
    }

    // MARK: - Page 2: Experience Level

    private var levelSelectorPage: some View {
        VStack(spacing: 0) {
            Spacer(minLength: AppDesign.Spacing.md)

            VStack(spacing: AppDesign.Spacing.sm) {
                Text("Your Current Level")
                    .font(AppDesign.Typography.headline)
                    .foregroundStyle(AppDesign.Colors.brightWhite)
                Text("TRAINING ADAPTS TO YOU")
                    .font(.system(size: 11, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppDesign.Colors.neonOrange)
                    .tracking(2)
            }
            .padding(.bottom, AppDesign.Spacing.lg)

            VStack(spacing: AppDesign.Spacing.sm) {
                ForEach(OnboardingData.levels) { level in
                    LevelCard(
                        level: level,
                        isSelected: selectedLevel == level.id
                    ) { selectedLevel = level.id }
                    .padding(.horizontal, AppDesign.Spacing.md)
                }
            }

            Spacer(minLength: AppDesign.Spacing.md)
        }
    }

    // MARK: - Page 3: Training Engine

    private var trainingEnginePage: some View {
        OnboardingInfoPageView(
            title: "The Training Engine",
            subtitle: "BUILT FOR EVERY LEVEL",
            bodyString: "41 exercises across 7 categories — each with coaching cues, muscle targets, and XP rewards. Every session is grounded in sports science.",
            iconName: "dumbbell.fill",
            accentColor: AppDesign.Colors.neonOrange,
            stats: [
                (value: "41", label: "Exercises"),
                (value: "12", label: "Disciplines"),
                (value: "7",  label: "Categories"),
                (value: "5",  label: "Stages"),
            ],
            bullets: [
                (icon: "bolt.fill",                text: "Progressive plyometric protocols from beginner to elite"),
                (icon: "dumbbell.fill",             text: "Strength and mobility balanced throughout every plan"),
                (icon: "checkmark.seal.fill",       text: "Step-by-step coaching cues for each exercise"),
                (icon: "chart.line.uptrend.xyaxis", text: "XP system tracks real athletic growth over time"),
            ]
        )
    }

    // MARK: - Page 4: AI Coach

    private var aiCoachPage: some View {
        OnboardingInfoPageView(
            title: "Your AI Coach",
            subtitle: "ALWAYS AVAILABLE · ALWAYS PRIVATE",
            bodyString: "Ask about jump technique, programming, biomechanics, or recovery. Powered by Apple Intelligence — runs entirely on your device.",
            iconName: "brain.head.profile",
            accentColor: AppDesign.Colors.dynamicBlue,
            bullets: [
                (icon: "iphone",     text: "On-device processing — zero cloud dependency"),
                (icon: "wifi.slash", text: "Works fully offline, no internet needed"),
                (icon: "lock.fill",  text: "No account, no tracking, no subscription"),
                (icon: "atom",       text: "Sports science knowledge: biomechanics, plyometrics, recovery"),
            ],
            footer: AnyView(
                Text("Powered by Apple Intelligence · Foundation Models")
                    .font(AppDesign.Typography.caption)
                    .foregroundStyle(AppDesign.Colors.mutedText)
                    .padding(.top, AppDesign.Spacing.sm)
            )
        )
    }

    // MARK: - Page 5: Evolution

    private var progressionPage: some View {
        OnboardingInfoPageView(
            title: "Evolve as an Athlete",
            subtitle: "5 STAGES · UNLIMITED GROWTH",
            bodyString: "Your Jump Evolution tracks real progress through 5 athlete stages. Earn XP every session, unlock disciplines, and set personal records.",
            iconName: "star.fill",
            accentColor: AppDesign.Colors.electricLime,
            bullets: [
                (icon: "bolt.fill",      text: "Earn XP for every exercise completed and session finished"),
                (icon: "map.fill",       text: "Unlock disciplines as your evolution stage rises"),
                (icon: "chart.bar.fill", text: "Track vertical jump, broad jump, reaction time metrics"),
                (icon: "trophy.fill",    text: "12 achievements across all training areas to collect"),
            ],
            footer: AnyView(evolutionStageScroll)
        )
    }

    private var evolutionStageScroll: some View {
        ScrollView(.horizontal) {
            HStack(spacing: AppDesign.Spacing.sm) {
                ForEach(0..<OnboardingData.evolutionPreviews.count, id: \.self) { i in
                    let stage = OnboardingData.evolutionPreviews[i]
                    VStack(spacing: 5) {
                        Image(systemName: stage.icon)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(AppDesign.Colors.electricLime)
                        Text(stage.name)
                            .font(.system(size: 9, weight: .semibold, design: .rounded))
                            .foregroundStyle(AppDesign.Colors.dimWhite)
                            .multilineTextAlignment(.center)
                        Text("Stage \(i + 1)")
                            .font(.system(size: 8, weight: .medium))
                            .foregroundStyle(AppDesign.Colors.mutedText)
                    }
                    .frame(width: 78)
                    .padding(.vertical, AppDesign.Spacing.sm)
                    .background(AppDesign.Colors.surface1)
                    .clipShape(.rect(cornerRadius: AppDesign.Radius.md))
                    .overlay {
                        RoundedRectangle(cornerRadius: AppDesign.Radius.md)
                            .strokeBorder(AppDesign.Colors.surface3, lineWidth: 1)
                    }
                }
            }
            .padding(.horizontal, AppDesign.Spacing.xs)
            .padding(.top, AppDesign.Spacing.sm)
        }
        .scrollIndicators(.hidden)
    }

    // MARK: - Page 6: Ready

    private var readyPage: some View {
        VStack(spacing: AppDesign.Spacing.xl) {
            Spacer()

            ZStack {
                Circle()
                    .fill(AppDesign.Colors.electricLime.opacity(0.12))
                    .frame(width: 150, height: 150)
                    .blur(radius: 28)
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 80, weight: .bold))
                    .foregroundStyle(AppDesign.Colors.electricLime)
                    .glowShadow(AppDesign.Colors.electricLime, radius: 24)
            }

            VStack(spacing: AppDesign.Spacing.sm) {
                Text("You're Ready to Evolve")
                    .font(AppDesign.Typography.headline)
                    .foregroundStyle(AppDesign.Colors.brightWhite)
                    .multilineTextAlignment(.center)
                Text(personalizedSummary)
                    .font(AppDesign.Typography.body)
                    .foregroundStyle(AppDesign.Colors.dimWhite)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, AppDesign.Spacing.xl)
            }

            if !selectedSports.isEmpty {
                selectedSportChips
            }

            Spacer()
        }
    }

    private var selectedSportChips: some View {
        ScrollView(.horizontal) {
            HStack(spacing: AppDesign.Spacing.sm) {
                ForEach(Array(selectedSports).sorted(), id: \.self) { id in
                    if let sport = OnboardingData.sports.first(where: { $0.id == id }) {
                        Label(sport.name, systemImage: sport.icon)
                            .font(AppDesign.Typography.caption)
                            .foregroundStyle(AppDesign.Colors.background)
                            .padding(.horizontal, AppDesign.Spacing.sm)
                            .padding(.vertical, 6)
                            .background(AppDesign.Colors.electricLime)
                            .clipShape(.capsule)
                    }
                }
            }
            .padding(.horizontal, AppDesign.Spacing.lg)
        }
        .scrollIndicators(.hidden)
    }

    private var personalizedSummary: String {
        let levelText: String
        switch selectedLevel {
        case "beginner":     levelText = "beginner"
        case "intermediate": levelText = "intermediate-level"
        case "advanced":     levelText = "advanced"
        default:             levelText = "athlete"
        }
        guard !selectedSports.isEmpty else {
            return "Your \(levelText) jump training program is ready. Build explosive power, technical precision, and real athletic consistency."
        }
        let names = selectedSports
            .compactMap { id in OnboardingData.sports.first { $0.id == id }?.name }
            .sorted()
            .joined(separator: " & ")
        return "Your \(levelText) program is set up for \(names). Build the explosive edge your sport demands."
    }

    // MARK: - Controls

    private var skipButton: some View {
        Button("Skip", action: completeOnboarding)
            .font(AppDesign.Typography.label)
            .foregroundStyle(AppDesign.Colors.mutedText)
            .padding(.vertical, AppDesign.Spacing.md)
    }

    private var bottomControls: some View {
        VStack(spacing: AppDesign.Spacing.lg) {
            pageIndicator
            actionButton
        }
    }

    private var pageIndicator: some View {
        HStack(spacing: 6) {
            ForEach(0..<totalPages, id: \.self) { i in
                Capsule()
                    .fill(currentPage == i ? AppDesign.Colors.electricLime : AppDesign.Colors.surface3)
                    .frame(width: currentPage == i ? 24 : 6, height: 6)
                    .animation(AppDesign.Anim.standard, value: currentPage)
            }
        }
        .accessibilityLabel("Page \(currentPage + 1) of \(totalPages)")
    }

    private var actionButton: some View {
        let isLast = currentPage == totalPages - 1
        return Button(action: handleAction) {
            HStack(spacing: AppDesign.Spacing.sm) {
                Text(isLast ? "Start Training" : "Continue")
                    .font(AppDesign.Typography.title3)
                    .foregroundStyle(AppDesign.Colors.background)
                Image(systemName: isLast ? "figure.gymnastics" : "arrow.right")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(AppDesign.Colors.background)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppDesign.Spacing.md)
            .background(isLast ?
                        AnyShapeStyle(AppDesign.Colors.electricLime) :
                        AnyShapeStyle(AppDesign.Colors.explosiveness))
            .clipShape(.rect(cornerRadius: AppDesign.Radius.full))
        }
        .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.7), trigger: currentPage)
        .animation(AppDesign.Anim.standard, value: currentPage)
        .accessibilityLabel(isLast ? "Start Training" : "Continue to next page")
    }

    // MARK: - Actions

    private func handleAction() {
        if currentPage < totalPages - 1 {
            withAnimation(reduceMotion ? .none : AppDesign.Anim.standard) {
                currentPage += 1
            }
        } else {
            completeOnboarding()
        }
    }

    private func completeOnboarding() {
        withAnimation(AppDesign.Anim.standard) {
            hasSeenOnboarding = true
        }
    }

    private func toggleSport(_ id: String) {
        withAnimation(AppDesign.Anim.fast) {
            if selectedSports.contains(id) {
                selectedSports.remove(id)
            } else {
                selectedSports.insert(id)
            }
        }
    }

    private func miniStatChip(_ value: String, _ label: String, _ color: Color) -> some View {
        VStack(spacing: 2) {
            Text(value)
                .font(.system(size: 20, weight: .black, design: .rounded))
                .foregroundStyle(color)
            Text(label)
                .font(.system(size: 10, weight: .medium))
                .foregroundStyle(AppDesign.Colors.mutedText)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, AppDesign.Spacing.sm)
        .background(color.opacity(0.08))
        .clipShape(.rect(cornerRadius: AppDesign.Radius.md))
    }
}

// MARK: - SportChip

private struct SportChip: View {
    let sport: OnboardingData.SportOption
    let isSelected: Bool
    let onTap: () -> Void

    private var accent: Color {
        switch sport.color {
        case "orange": AppDesign.Colors.neonOrange
        case "blue":   AppDesign.Colors.dynamicBlue
        default:       AppDesign.Colors.electricLime
        }
    }

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 6) {
                Image(systemName: sport.icon)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(isSelected ? AppDesign.Colors.background : accent)
                Text(sport.name)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundStyle(isSelected ? AppDesign.Colors.background : AppDesign.Colors.dimWhite)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppDesign.Spacing.md)
            .background(isSelected ? accent : AppDesign.Colors.surface2)
            .clipShape(.rect(cornerRadius: AppDesign.Radius.lg))
            .overlay {
                if !isSelected {
                    RoundedRectangle(cornerRadius: AppDesign.Radius.lg)
                        .strokeBorder(accent.opacity(0.3), lineWidth: 1)
                }
            }
        }
        .sensoryFeedback(.impact(flexibility: .soft), trigger: isSelected)
        .animation(AppDesign.Anim.standard, value: isSelected)
        .accessibilityLabel("\(sport.name)\(isSelected ? ", selected" : "")")
    }
}

// MARK: - LevelCard

private struct LevelCard: View {
    let level: OnboardingData.LevelOption
    let isSelected: Bool
    let onTap: () -> Void

    private var accent: Color {
        switch level.id {
        case "intermediate": AppDesign.Colors.neonOrange
        case "advanced":     .red
        default:             AppDesign.Colors.electricLime
        }
    }

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: AppDesign.Spacing.md) {
                ZStack {
                    RoundedRectangle(cornerRadius: AppDesign.Radius.sm)
                        .fill(accent.opacity(isSelected ? 0.2 : 0.07))
                        .frame(width: 48, height: 48)
                    Image(systemName: level.icon)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(isSelected ? accent : AppDesign.Colors.graphite)
                }
                VStack(alignment: .leading, spacing: 3) {
                    Text(level.name)
                        .font(AppDesign.Typography.label)
                        .foregroundStyle(isSelected ? AppDesign.Colors.brightWhite : AppDesign.Colors.dimWhite)
                    Text(level.description)
                        .font(AppDesign.Typography.caption)
                        .foregroundStyle(AppDesign.Colors.mutedText)
                    Text(level.hint)
                        .font(.system(size: 10, weight: .medium, design: .rounded))
                        .foregroundStyle(isSelected ? accent.opacity(0.85) : AppDesign.Colors.surface3)
                }
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 22))
                        .foregroundStyle(accent)
                }
            }
            .padding(AppDesign.Spacing.md)
            .background(isSelected ? accent.opacity(0.07) : AppDesign.Colors.surface1)
            .clipShape(.rect(cornerRadius: AppDesign.Radius.lg))
            .overlay {
                RoundedRectangle(cornerRadius: AppDesign.Radius.lg)
                    .strokeBorder(
                        isSelected ? accent.opacity(0.5) : AppDesign.Colors.surface3,
                        lineWidth: isSelected ? 1.5 : 1
                    )
            }
        }
        .sensoryFeedback(.impact(flexibility: .soft), trigger: isSelected)
        .animation(AppDesign.Anim.standard, value: isSelected)
        .accessibilityLabel("\(level.name). \(level.description)\(isSelected ? ". Selected." : "")")
    }
}

#Preview {
    OnboardingView(hasSeenOnboarding: .constant(false))
}
