import SwiftUI
import SwiftData

struct TrainingView: View {

    @Environment(AppState.self) private var appState
    @Environment(SubscriptionManagerBPV.self) private var purchaseManager
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = TrainingViewModel()
    @State private var selectedDiscipline: SportDiscipline? = nil
    @State private var showDisciplinePicker = false
    @State private var showStore = false
    @State private var showRestTimer = false

    private var isPremium: Bool {
        purchaseManager.isPurchased(.extremeMotionPack)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                AppDesign.Colors.background.ignoresSafeArea()

                ScrollView {
                    LazyVStack(spacing: AppDesign.Spacing.lg) {
                        if viewModel.sessionActive {
                            activeSessionHeader
                        } else {
                            disciplineSelectorSection
                        }
                        categoryFilterSection
                        exerciseListSection
                    }
                    .padding(.horizontal, AppDesign.Spacing.md)
                    .padding(.bottom, AppDesign.Spacing.xxl)
                }
                .scrollIndicators(.hidden)

                if viewModel.showCompletionBanner {
                    completionBanner
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .zIndex(1)
                }
            }
            .navigationTitle("Training")
            .toolbar { toolbarContent }
            .navigationDestination(for: Exercise.self) { exercise in
                ExerciseDetailView(exercise: exercise)
            }
            .sheet(isPresented: $showStore) {
                StoreView()
            }
            .sheet(isPresented: $showRestTimer) {
                RestTimerView(isPresented: $showRestTimer)
            }
        }
    }

    // MARK: - Sections

    private var disciplineSelectorSection: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.sm) {
            sectionTitle("Select Discipline", icon: "figure.gymnastics")
            ScrollView(.horizontal) {
                HStack(spacing: AppDesign.Spacing.sm) {
                    ForEach(viewModel.disciplines) { discipline in
                        if discipline.isPremium && !isPremium {
                            LockedDisciplineChip(discipline: discipline) { showStore = true }
                        } else {
                            DisciplineChip(
                                discipline: discipline,
                                isSelected: viewModel.currentDiscipline?.id == discipline.id,
                                onSelect: { viewModel.currentDiscipline = discipline }
                            )
                        }
                    }
                }
                .padding(.horizontal, AppDesign.Spacing.xs)
            }
            .scrollIndicators(.hidden)

            Button(action: startSession) {
                Label("Start Training Session", systemImage: "bolt.fill")
                    .font(AppDesign.Typography.title3)
                    .foregroundStyle(AppDesign.Colors.background)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, AppDesign.Spacing.md)
                    .background(AppDesign.Colors.explosiveness)
                    .clipShape(.rect(cornerRadius: AppDesign.Radius.full))
            }
            .padding(.top, AppDesign.Spacing.sm)
            .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.8), trigger: viewModel.sessionActive)
        }
    }

    private var activeSessionHeader: some View {
        VStack(spacing: AppDesign.Spacing.md) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Session Active")
                        .font(AppDesign.Typography.caption)
                        .foregroundStyle(AppDesign.Colors.electricLime)
                    Text(viewModel.currentDiscipline?.name ?? "General Training")
                        .font(AppDesign.Typography.title)
                        .foregroundStyle(AppDesign.Colors.brightWhite)
                }
                Spacer()
                TimerBadge(startTime: viewModel.sessionStartTime)
            }

            HStack(spacing: AppDesign.Spacing.md) {
                statPill(label: "Done", value: "\(viewModel.completedExerciseIDs.count)/\(viewModel.sessionExercises.count)", icon: "checkmark.circle.fill", color: AppDesign.Colors.electricLime)
                statPill(label: "XP Earned", value: "+\(viewModel.sessionXPEarned)", icon: "bolt.fill", color: AppDesign.Colors.neonOrange)
            }

            Button(action: finishSession) {
                Label("Finish Session", systemImage: "flag.fill")
                    .font(AppDesign.Typography.label)
                    .foregroundStyle(AppDesign.Colors.brightWhite)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, AppDesign.Spacing.sm)
                    .background(AppDesign.Colors.surface2)
                    .clipShape(.rect(cornerRadius: AppDesign.Radius.full))
            }
        }
        .sportCard()
    }

    private var categoryFilterSection: some View {
        ScrollView(.horizontal) {
            HStack(spacing: AppDesign.Spacing.sm) {
                CategoryChip(
                    title: "All",
                    icon: "square.grid.2x2.fill",
                    isSelected: viewModel.selectedCategory == nil,
                    onSelect: { viewModel.selectedCategory = nil }
                )
                ForEach(Exercise.Category.allCases, id: \.self) { cat in
                    CategoryChip(
                        title: cat.rawValue,
                        icon: cat.iconName,
                        isSelected: viewModel.selectedCategory == cat,
                        onSelect: { viewModel.selectedCategory = cat }
                    )
                }
            }
            .padding(.horizontal, AppDesign.Spacing.xs)
        }
        .scrollIndicators(.hidden)
    }

    private var exerciseListSection: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.sm) {
            sectionTitle("Exercises", icon: "dumbbell.fill")
            ForEach(viewModel.filteredExercises) { exercise in
                NavigationLink(value: exercise) {
                    ExerciseCardView(
                        exercise: exercise,
                        isCompleted: viewModel.completedExerciseIDs.contains(exercise.id),
                        onToggle: {
                            let wasCompleted = viewModel.completedExerciseIDs.contains(exercise.id)
                            viewModel.toggleExercise(exercise)
                            if !wasCompleted && viewModel.sessionActive {
                                showRestTimer = true
                            }
                        }
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var completionBanner: some View {
        VStack {
            HStack(spacing: AppDesign.Spacing.sm) {
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(AppDesign.Colors.electricLime)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Session Complete!")
                        .font(AppDesign.Typography.label)
                        .foregroundStyle(AppDesign.Colors.brightWhite)
                    Text("+\(viewModel.sessionXPEarned) XP earned")
                        .font(AppDesign.Typography.caption)
                        .foregroundStyle(AppDesign.Colors.electricLime)
                }
            }
            .padding(AppDesign.Spacing.md)
            .background(AppDesign.Colors.surface2)
            .clipShape(.rect(cornerRadius: AppDesign.Radius.lg))
            .overlay {
                RoundedRectangle(cornerRadius: AppDesign.Radius.lg)
                    .strokeBorder(AppDesign.Colors.electricLime.opacity(0.4), lineWidth: 1)
            }
            .shadow(color: AppDesign.Colors.electricLime.opacity(0.3), radius: 12)
            Spacer()
        }
        .padding(.top, AppDesign.Spacing.md)
    }

    // MARK: - Toolbar

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            HStack(spacing: 4) {
                Image(systemName: "flame.fill")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(AppDesign.Colors.neonOrange)
                Text("\(appState.progression.userProgress.currentStreak) day streak")
                    .font(AppDesign.Typography.label)
                    .foregroundStyle(AppDesign.Colors.dimWhite)
            }
        }
    }

    // MARK: - Helpers

    private func sectionTitle(_ text: String, icon: String) -> some View {
        Label(text, systemImage: icon)
            .font(AppDesign.Typography.title3)
            .foregroundStyle(AppDesign.Colors.brightWhite)
    }

    private func statPill(label: String, value: String, icon: String, color: Color) -> some View {
        HStack(spacing: 4) {
            Image(systemName: icon).font(.system(size: 12, weight: .semibold)).foregroundStyle(color)
            VStack(alignment: .leading, spacing: 1) {
                Text(value).font(AppDesign.Typography.label).foregroundStyle(AppDesign.Colors.brightWhite)
                Text(label).font(AppDesign.Typography.caption).foregroundStyle(AppDesign.Colors.dimWhite)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(AppDesign.Spacing.sm)
        .background(color.opacity(0.1))
        .clipShape(.rect(cornerRadius: AppDesign.Radius.md))
    }

    private func startSession() {
        viewModel.startSession(discipline: viewModel.currentDiscipline)
    }

    private func finishSession() {
        viewModel.finishSession(progression: appState.progression, modelContext: modelContext)
    }
}

// MARK: - DisciplineChip

private struct DisciplineChip: View {
    let discipline: SportDiscipline
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            VStack(spacing: 4) {
                Image(systemName: discipline.iconName)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(isSelected ? AppDesign.Colors.background : AppDesign.Colors.electricLime)
                Text(discipline.name)
                    .font(AppDesign.Typography.caption)
                    .foregroundStyle(isSelected ? AppDesign.Colors.background : AppDesign.Colors.dimWhite)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(width: 80)
            .padding(.vertical, AppDesign.Spacing.sm)
            .padding(.horizontal, AppDesign.Spacing.xs)
            .background(isSelected ? AppDesign.Colors.electricLime : AppDesign.Colors.surface2)
            .clipShape(.rect(cornerRadius: AppDesign.Radius.md))
        }
        .animation(AppDesign.Anim.standard, value: isSelected)
    }
}

// MARK: - LockedDisciplineChip

private struct LockedDisciplineChip: View {
    let discipline: SportDiscipline
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 4) {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: discipline.iconName)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(AppDesign.Colors.graphite)
                    Image(systemName: "lock.fill")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundStyle(AppDesign.Colors.neonOrange)
                        .offset(x: 4, y: -4)
                }
                Text(discipline.name)
                    .font(AppDesign.Typography.caption)
                    .foregroundStyle(AppDesign.Colors.mutedText)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                Text("Unlock")
                    .font(.system(size: 9, weight: .bold, design: .rounded))
                    .foregroundStyle(AppDesign.Colors.neonOrange)
            }
            .frame(width: 80)
            .padding(.vertical, AppDesign.Spacing.sm)
            .padding(.horizontal, AppDesign.Spacing.xs)
            .background(AppDesign.Colors.surface1)
            .clipShape(.rect(cornerRadius: AppDesign.Radius.md))
            .overlay {
                RoundedRectangle(cornerRadius: AppDesign.Radius.md)
                    .strokeBorder(AppDesign.Colors.neonOrange.opacity(0.35), lineWidth: 1)
            }
        }
        .accessibilityLabel("\(discipline.name), locked. Tap to unlock with Extreme Motion Pack.")
    }
}

// MARK: - CategoryChip

private struct CategoryChip: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            Label(title, systemImage: icon)
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

// MARK: - TimerBadge

private struct TimerBadge: View {
    let startTime: Date
    @State private var elapsed = 0

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "timer")
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(AppDesign.Colors.neonOrange)
            Text(formatElapsed(elapsed))
                .font(.system(size: 14, weight: .black, design: .monospaced))
                .foregroundStyle(AppDesign.Colors.brightWhite)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(AppDesign.Colors.neonOrange.opacity(0.12))
        .clipShape(.capsule)
        .task {
            do {
                while true {
                    try await Task.sleep(for: .seconds(1))
                    elapsed = Int(Date.now.timeIntervalSince(startTime))
                }
            } catch {}
        }
    }

    private func formatElapsed(_ seconds: Int) -> String {
        let m = seconds / 60
        let s = seconds % 60
        return String(format: "%02d:%02d", m, s)
    }
}

// MARK: - ExerciseDetailView

private struct ExerciseDetailView: View {
    let exercise: Exercise
    @Environment(SubscriptionManagerBPV.self) private var purchaseManager
    @State private var showStore = false

    private var isLocked: Bool {
        guard exercise.isPremium, let pack = exercise.premiumPack else { return false }
        return !purchaseManager.isPurchased(pack)
    }

    var body: some View {
        ZStack {
            AppDesign.Colors.background.ignoresSafeArea()
            if isLocked {
                premiumGateView
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: AppDesign.Spacing.lg) {
                        headerCard
                        coachingCuesSection
                        muscleGroupsSection
                    }
                    .padding(AppDesign.Spacing.md)
                    .padding(.bottom, AppDesign.Spacing.xxl)
                }
                .scrollIndicators(.hidden)
            }
        }
        .navigationTitle(exercise.name)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showStore) { StoreView() }
    }

    private var premiumGateView: some View {
        VStack(spacing: AppDesign.Spacing.xl) {
            Spacer()
            ZStack {
                Circle()
                    .fill(AppDesign.Colors.neonOrange.opacity(0.12))
                    .frame(width: 96, height: 96)
                Image(systemName: "lock.fill")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundStyle(AppDesign.Colors.neonOrange)
            }
            VStack(spacing: AppDesign.Spacing.sm) {
                Text("Premium Exercise")
                    .font(AppDesign.Typography.headline)
                    .foregroundStyle(AppDesign.Colors.brightWhite)
                Text("This exercise is part of the Elite Explosiveness Pack. Unlock it for advanced technique breakdowns, coaching cues, and XP rewards.")
                    .font(AppDesign.Typography.body)
                    .foregroundStyle(AppDesign.Colors.dimWhite)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, AppDesign.Spacing.lg)
            }
            Button(action: { showStore = true }) {
                Label("Unlock – Elite Explosiveness Pack", systemImage: "bolt.fill")
                    .font(AppDesign.Typography.title3)
                    .foregroundStyle(AppDesign.Colors.background)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, AppDesign.Spacing.md)
                    .background(AppDesign.Colors.electricLime)
                    .clipShape(.rect(cornerRadius: AppDesign.Radius.full))
            }
            .padding(.horizontal, AppDesign.Spacing.lg)
            Spacer()
        }
    }

    private var headerCard: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.md) {
            HStack {
                Label(exercise.category.rawValue, systemImage: exercise.category.iconName)
                    .font(AppDesign.Typography.label)
                    .foregroundStyle(AppDesign.Colors.electricLime)
                Spacer()
                Text(exercise.difficulty.label)
                    .font(AppDesign.Typography.caption)
                    .foregroundStyle(AppDesign.Colors.neonOrange)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(AppDesign.Colors.neonOrange.opacity(0.12))
                    .clipShape(.capsule)
            }
            Text(exercise.description)
                .font(AppDesign.Typography.body)
                .foregroundStyle(AppDesign.Colors.dimWhite)
                .lineSpacing(4)
            HStack(spacing: AppDesign.Spacing.lg) {
                statItem(label: "Sets", value: "\(exercise.sets)")
                statItem(label: "Reps", value: exercise.repsDisplay)
                statItem(label: "Rest", value: "\(exercise.restSeconds)s")
                statItem(label: "XP", value: "+\(exercise.xpReward)")
            }
        }
        .sportCard()
    }

    private var coachingCuesSection: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.sm) {
            Label("Coaching Cues", systemImage: "checkmark.seal.fill")
                .font(AppDesign.Typography.title3)
                .foregroundStyle(AppDesign.Colors.brightWhite)
            ForEach(exercise.coachingCues, id: \.self) { cue in
                HStack(alignment: .top, spacing: AppDesign.Spacing.sm) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(AppDesign.Colors.electricLime)
                        .padding(.top, 4)
                    Text(cue)
                        .font(AppDesign.Typography.body)
                        .foregroundStyle(AppDesign.Colors.dimWhite)
                        .lineSpacing(3)
                }
            }
        }
    }

    private var muscleGroupsSection: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.sm) {
            Label("Muscles Trained", systemImage: "figure.walk")
                .font(AppDesign.Typography.title3)
                .foregroundStyle(AppDesign.Colors.brightWhite)
            FlowLayout(items: exercise.muscleGroups) { muscle in
                Text(muscle)
                    .font(AppDesign.Typography.caption)
                    .foregroundStyle(AppDesign.Colors.electricLime)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(AppDesign.Colors.electricLime.opacity(0.1))
                    .clipShape(.capsule)
            }
        }
    }

    private func statItem(label: String, value: String) -> some View {
        VStack(spacing: 2) {
            Text(value)
                .font(.system(size: 20, weight: .black, design: .rounded))
                .foregroundStyle(AppDesign.Colors.brightWhite)
            Text(label)
                .font(AppDesign.Typography.caption)
                .foregroundStyle(AppDesign.Colors.mutedText)
        }
    }
}

// MARK: - FlowLayout

private struct FlowLayout<Item: Hashable, Content: View>: View {
    let items: [Item]
    @ViewBuilder let content: (Item) -> Content

    var body: some View {
        // Simple wrapping layout using LazyVStack with horizontal groups
        LazyVStack(alignment: .leading, spacing: 6) {
            // Chunked into rows
            ForEach(chunkedItems, id: \.self) { row in
                HStack(spacing: 6) {
                    ForEach(row, id: \.self) { item in
                        content(item)
                    }
                }
            }
        }
    }

    private var chunkedItems: [[Item]] {
        var result: [[Item]] = [[]]
        for item in items {
            if result[result.count - 1].count < 3 {
                result[result.count - 1].append(item)
            } else {
                result.append([item])
            }
        }
        return result
    }
}

#Preview {
    TrainingView()
        .environment(AppState(progress: UserProgress()))
        .environment(SubscriptionManagerBPV())
}
