import SwiftUI

struct EducationView: View {

    @Environment(AppState.self) private var appState
    @Environment(SubscriptionManagerBPV.self) private var purchaseManager
    @State private var selectedCategory: SportDiscipline.Category? = nil
    @State private var selectedDiscipline: SportDiscipline? = nil
    @State private var searchText = ""

    private var isPremium: Bool {
        purchaseManager.isPurchased(.extremeMotionPack)
    }

    private var filteredDisciplines: [SportDiscipline] {
        TrainingDataStore.disciplines.filter { discipline in
            let matchesCategory = selectedCategory == nil || discipline.category == selectedCategory
            let matchesSearch = searchText.isEmpty || discipline.name.localizedStandardContains(searchText)
            return matchesCategory && matchesSearch
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                AppDesign.Colors.background.ignoresSafeArea()
                ScrollView {
                    LazyVStack(spacing: AppDesign.Spacing.lg) {
                        categoryScroll
                        disciplineGrid
                    }
                    .padding(.horizontal, AppDesign.Spacing.md)
                    .padding(.bottom, AppDesign.Spacing.xxl)
                }
                .scrollIndicators(.hidden)
            }
            .navigationTitle("Education")
            .searchable(text: $searchText, prompt: "Search disciplines…")
            .navigationDestination(for: SportDiscipline.self) { discipline in
                DisciplineDetailView(discipline: discipline)
            }
        }
    }

    private var categoryScroll: some View {
        ScrollView(.horizontal) {
            HStack(spacing: AppDesign.Spacing.sm) {
                CategoryPill(title: "All", isSelected: selectedCategory == nil) {
                    selectedCategory = nil
                }
                ForEach(SportDiscipline.Category.allCases, id: \.self) { cat in
                    CategoryPill(title: cat.rawValue, isSelected: selectedCategory == cat) {
                        selectedCategory = cat
                    }
                }
            }
            .padding(.horizontal, AppDesign.Spacing.xs)
        }
        .scrollIndicators(.hidden)
    }

    private var disciplineGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: AppDesign.Spacing.sm) {
            ForEach(filteredDisciplines) { discipline in
                NavigationLink(value: discipline) {
                    DisciplineCard(discipline: discipline, isPremiumUnlocked: isPremium)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

// MARK: - DisciplineCard

private struct DisciplineCard: View {
    let discipline: SportDiscipline
    let isPremiumUnlocked: Bool

    private var isLocked: Bool { discipline.isPremium && !isPremiumUnlocked }

    private var difficultyColor: Color {
        switch discipline.difficulty {
        case .beginner:     AppDesign.Colors.electricLime
        case .intermediate: AppDesign.Colors.dynamicBlue
        case .advanced:     AppDesign.Colors.neonOrange
        case .elite:        Color.red
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.sm) {
            HStack {
                Image(systemName: discipline.iconName)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(isLocked ? AppDesign.Colors.mutedText : AppDesign.Colors.electricLime)
                Spacer()
                if isLocked {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 13))
                        .foregroundStyle(AppDesign.Colors.neonOrange)
                } else {
                    Text(discipline.difficulty.label)
                        .font(AppDesign.Typography.caption)
                        .foregroundStyle(difficultyColor)
                }
            }

            Text(discipline.name)
                .font(AppDesign.Typography.label)
                .foregroundStyle(isLocked ? AppDesign.Colors.dimWhite : AppDesign.Colors.brightWhite)
                .lineLimit(2)

            Text(discipline.subtitle)
                .font(AppDesign.Typography.caption)
                .foregroundStyle(AppDesign.Colors.mutedText)
                .lineLimit(1)

            Text(discipline.category.rawValue)
                .font(.system(size: 10, weight: .medium, design: .rounded))
                .foregroundStyle(AppDesign.Colors.dynamicBlue)
                .tracking(1)
        }
        .sportCard()
        .opacity(isLocked ? 0.6 : 1.0)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(discipline.name). \(discipline.difficulty.label). \(isLocked ? "Locked — premium required." : "")")
    }
}

// MARK: - CategoryPill

private struct CategoryPill: View {
    let title: String
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            Text(title)
                .font(AppDesign.Typography.caption)
                .foregroundStyle(isSelected ? AppDesign.Colors.background : AppDesign.Colors.dimWhite)
                .padding(.horizontal, AppDesign.Spacing.sm)
                .padding(.vertical, 6)
                .background(isSelected ? AppDesign.Colors.electricLime : AppDesign.Colors.surface2)
                .clipShape(.capsule)
        }
        .animation(AppDesign.Anim.fast, value: isSelected)
    }
}

// MARK: - DisciplineDetailView

struct DisciplineDetailView: View {
    let discipline: SportDiscipline
    @Environment(SubscriptionManagerBPV.self) private var purchaseManager
    @State private var showStore = false

    private var isLocked: Bool {
        guard discipline.isPremium, let pack = discipline.premiumPack else { return false }
        return !purchaseManager.isPurchased(pack)
    }

    var body: some View {
        ZStack {
            AppDesign.Colors.background.ignoresSafeArea()
            if isLocked {
                premiumGateView
            } else {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: AppDesign.Spacing.lg) {
                        headerBanner
                        descriptionSection
                        scienceFactSection
                        musclesSection
                        skillsSection
                        relatedExercises
                    }
                    .padding(.horizontal, AppDesign.Spacing.md)
                    .padding(.bottom, AppDesign.Spacing.xxl)
                }
                .scrollIndicators(.hidden)
            }
        }
        .navigationTitle(discipline.name)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showStore) { StoreView() }
    }

    private var premiumGateView: some View {
        VStack(spacing: AppDesign.Spacing.xl) {
            Spacer()
            ZStack {
                Circle()
                    .fill(AppDesign.Colors.dynamicBlue.opacity(0.12))
                    .frame(width: 96, height: 96)
                Image(systemName: discipline.iconName)
                    .font(.system(size: 40, weight: .bold))
                    .foregroundStyle(AppDesign.Colors.dynamicBlue.opacity(0.5))
                Image(systemName: "lock.fill")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(AppDesign.Colors.neonOrange)
                    .offset(x: 22, y: 22)
            }
            VStack(spacing: AppDesign.Spacing.sm) {
                Text("Premium Discipline")
                    .font(AppDesign.Typography.headline)
                    .foregroundStyle(AppDesign.Colors.brightWhite)
                Text("\(discipline.name) is part of the Extreme Motion Pack — unlock full technique breakdowns, science facts, training skills, and coaching programs.")
                    .font(AppDesign.Typography.body)
                    .foregroundStyle(AppDesign.Colors.dimWhite)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, AppDesign.Spacing.lg)
            }
            Button(action: { showStore = true }) {
                Label("Unlock – Extreme Motion Pack", systemImage: "figure.gymnastics")
                    .font(AppDesign.Typography.title3)
                    .foregroundStyle(AppDesign.Colors.background)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, AppDesign.Spacing.md)
                    .background(AppDesign.Colors.dynamicBlue)
                    .clipShape(.rect(cornerRadius: AppDesign.Radius.full))
            }
            .padding(.horizontal, AppDesign.Spacing.lg)
            Spacer()
        }
    }

    private var headerBanner: some View {
        HStack(spacing: AppDesign.Spacing.lg) {
            Image(systemName: discipline.iconName)
                .font(.system(size: 48, weight: .bold))
                .foregroundStyle(AppDesign.Colors.explosiveness)

            VStack(alignment: .leading, spacing: 4) {
                Text(discipline.category.rawValue)
                    .font(AppDesign.Typography.caption)
                    .foregroundStyle(AppDesign.Colors.dynamicBlue)
                    .tracking(1)
                Text(discipline.subtitle)
                    .font(AppDesign.Typography.title)
                    .foregroundStyle(AppDesign.Colors.brightWhite)
                difficultyBadge
            }
        }
        .padding(AppDesign.Spacing.lg)
        .background(AppDesign.Colors.cardSurface)
        .clipShape(.rect(cornerRadius: AppDesign.Radius.xl))
    }

    private var difficultyBadge: some View {
        let color: Color = switch discipline.difficulty {
        case .beginner:     AppDesign.Colors.electricLime
        case .intermediate: AppDesign.Colors.dynamicBlue
        case .advanced:     AppDesign.Colors.neonOrange
        case .elite:        .red
        }
        return Text(discipline.difficulty.label)
            .font(AppDesign.Typography.caption)
            .foregroundStyle(color)
            .padding(.horizontal, 10)
            .padding(.vertical, 3)
            .background(color.opacity(0.12))
            .clipShape(.capsule)
    }

    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.sm) {
            sectionHeader("Overview", icon: "doc.text.fill")
            Text(discipline.description)
                .font(AppDesign.Typography.body)
                .foregroundStyle(AppDesign.Colors.dimWhite)
                .lineSpacing(5)
        }
    }

    private var scienceFactSection: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.sm) {
            sectionHeader("Science Fact", icon: "atom")
            HStack(alignment: .top, spacing: AppDesign.Spacing.sm) {
                Image(systemName: "lightbulb.fill")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(AppDesign.Colors.electricLime)
                Text(discipline.scienceFact)
                    .font(AppDesign.Typography.body)
                    .foregroundStyle(AppDesign.Colors.dimWhite)
                    .lineSpacing(4)
            }
            .sportCard()
        }
    }

    private var musclesSection: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.sm) {
            sectionHeader("Key Muscles", icon: "figure.walk")
            ScrollView(.horizontal) {
                HStack(spacing: AppDesign.Spacing.sm) {
                    ForEach(discipline.keyMuscles, id: \.self) { muscle in
                        Text(muscle)
                            .font(AppDesign.Typography.caption)
                            .foregroundStyle(AppDesign.Colors.electricLime)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(AppDesign.Colors.electricLime.opacity(0.1))
                            .clipShape(.capsule)
                    }
                }
                .padding(.horizontal, AppDesign.Spacing.xs)
            }
            .scrollIndicators(.hidden)
        }
    }

    private var skillsSection: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.sm) {
            sectionHeader("Core Skills", icon: "checkmark.seal.fill")
            VStack(alignment: .leading, spacing: 8) {
                ForEach(discipline.coreSkills, id: \.self) { skill in
                    HStack(spacing: AppDesign.Spacing.sm) {
                        Image(systemName: "bolt.fill")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(AppDesign.Colors.neonOrange)
                        Text(skill)
                            .font(AppDesign.Typography.body)
                            .foregroundStyle(AppDesign.Colors.dimWhite)
                    }
                }
            }
        }
    }

    private var relatedExercises: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.sm) {
            sectionHeader("Related Exercises", icon: "dumbbell.fill")
            ForEach(TrainingDataStore.exercises.filter { !$0.isPremium }.prefix(3)) { exercise in
                ExerciseCardView(exercise: exercise)
            }
        }
    }

    private func sectionHeader(_ title: String, icon: String) -> some View {
        Label(title, systemImage: icon)
            .font(AppDesign.Typography.title3)
            .foregroundStyle(AppDesign.Colors.brightWhite)
    }
}

#Preview {
    EducationView()
        .environment(AppState(progress: UserProgress()))
        .environment(SubscriptionManagerBPV())
}
