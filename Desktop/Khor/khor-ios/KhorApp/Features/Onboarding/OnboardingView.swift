import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var appState: AppState
    @State private var currentStep = 0
    @State private var profile = UserProfile()

    private let totalSteps = 5

    var body: some View {
        ZStack {
            KhorColors.background.ignoresSafeArea()

            VStack(spacing: 0) {
                // Progress bar
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Rectangle().fill(KhorColors.surfaceMid).frame(height: 3)
                        Rectangle()
                            .fill(LinearGradient(colors: [KhorColors.accent, KhorColors.accentCyan], startPoint: .leading, endPoint: .trailing))
                            .frame(width: geo.size.width * CGFloat(currentStep + 1) / CGFloat(totalSteps), height: 3)
                    }
                }
                .frame(height: 3)

                Spacer()

                switch currentStep {
                case 0:
                    OnboardingGoalStep(selected: $profile.fitnessGoals, onNext: nextStep)
                case 1:
                    OnboardingLevelStep(selected: $profile.userLevel, onNext: nextStep)
                case 2:
                    OnboardingLocationStep(selected: $profile.trainingLocation, onNext: nextStep)
                case 3:
                    OnboardingBodyStep(profile: $profile, onNext: nextStep)
                case 4:
                    OnboardingDaysStep(days: $profile.trainingDaysPerWeek, onFinish: finish)
                default:
                    EmptyView()
                }

                Spacer()
            }
        }
    }

    private func nextStep() {
        withAnimation { currentStep += 1 }
    }

    private func finish() {
        appState.isOnboardingComplete = true
    }
}

struct OnboardingGoalStep: View {
    @Binding var selected: [FitnessGoal]
    let onNext: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 8) {
                Text("¿Cuál es tu objetivo?")
                    .font(KhorFonts.displayMedium())
                    .foregroundColor(KhorColors.textPrimary)
                    .multilineTextAlignment(.center)
                Text("Puedes elegir varios")
                    .font(KhorFonts.body())
                    .foregroundColor(KhorColors.textTertiary)
            }

            VStack(spacing: 12) {
                ForEach(FitnessGoal.allCases, id: \.self) { goal in
                    let isSelected = selected.contains(goal)
                    Button {
                        if isSelected {
                            selected.removeAll { $0 == goal }
                        } else {
                            selected.append(goal)
                        }
                    } label: {
                        HStack(spacing: 14) {
                            Text(goal.emoji).font(.system(size: 24))
                            Text(goal.displayName)
                                .font(KhorFonts.titleMedium())
                            Spacer()
                            if isSelected {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(KhorColors.accent)
                            }
                        }
                        .foregroundColor(isSelected ? KhorColors.textPrimary : KhorColors.textSecondary)
                        .padding(16)
                        .background(isSelected ? KhorColors.accent.opacity(0.15) : KhorColors.surface)
                        .cornerRadius(14)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(isSelected ? KhorColors.accent : Color.clear, lineWidth: 1.5)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }

            KhorPrimaryButton(title: "Continuar", disabled: selected.isEmpty, action: onNext)
        }
        .padding(.horizontal, 24)
    }
}

struct OnboardingLevelStep: View {
    @Binding var selected: UserLevel
    let onNext: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Text("¿Cuál es tu nivel?")
                .font(KhorFonts.displayMedium())
                .foregroundColor(KhorColors.textPrimary)
                .multilineTextAlignment(.center)

            VStack(spacing: 12) {
                ForEach(UserLevel.allCases, id: \.self) { level in
                    Button { selected = level } label: {
                        HStack {
                            Text(level.displayName)
                                .font(KhorFonts.titleMedium())
                                .foregroundColor(selected == level ? KhorColors.textPrimary : KhorColors.textSecondary)
                            Spacer()
                            if selected == level {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(KhorColors.accent)
                            }
                        }
                        .padding(16)
                        .background(selected == level ? KhorColors.accent.opacity(0.15) : KhorColors.surface)
                        .cornerRadius(14)
                        .overlay(RoundedRectangle(cornerRadius: 14).stroke(selected == level ? KhorColors.accent : Color.clear, lineWidth: 1.5))
                    }
                    .buttonStyle(.plain)
                }
            }

            KhorPrimaryButton(title: "Continuar", action: onNext)
        }
        .padding(.horizontal, 24)
    }
}

struct OnboardingLocationStep: View {
    @Binding var selected: TrainingLocation
    let onNext: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Text("¿Dónde entrenas?")
                .font(KhorFonts.displayMedium())
                .foregroundColor(KhorColors.textPrimary)
                .multilineTextAlignment(.center)

            VStack(spacing: 12) {
                ForEach(TrainingLocation.allCases, id: \.self) { loc in
                    Button { selected = loc } label: {
                        HStack {
                            Text(loc.displayName)
                                .font(KhorFonts.titleMedium())
                                .foregroundColor(selected == loc ? KhorColors.textPrimary : KhorColors.textSecondary)
                            Spacer()
                            if selected == loc {
                                Image(systemName: "checkmark.circle.fill").foregroundColor(KhorColors.accent)
                            }
                        }
                        .padding(16)
                        .background(selected == loc ? KhorColors.accent.opacity(0.15) : KhorColors.surface)
                        .cornerRadius(14)
                        .overlay(RoundedRectangle(cornerRadius: 14).stroke(selected == loc ? KhorColors.accent : Color.clear, lineWidth: 1.5))
                    }
                    .buttonStyle(.plain)
                }
            }

            KhorPrimaryButton(title: "Continuar", action: onNext)
        }
        .padding(.horizontal, 24)
    }
}

struct OnboardingBodyStep: View {
    @Binding var profile: UserProfile
    let onNext: () -> Void
    @State private var weightStr = ""
    @State private var heightStr = ""
    @State private var ageStr = ""

    var body: some View {
        VStack(spacing: 24) {
            Text("Tu datos físicos")
                .font(KhorFonts.displayMedium())
                .foregroundColor(KhorColors.textPrimary)

            VStack(spacing: 14) {
                KhorTextField(placeholder: "Edad", text: $ageStr, keyboardType: .numberPad)
                KhorTextField(placeholder: "Peso (kg)", text: $weightStr, keyboardType: .decimalPad)
                KhorTextField(placeholder: "Altura (cm)", text: $heightStr, keyboardType: .numberPad)
            }

            KhorPrimaryButton(title: "Continuar") {
                profile.age = Int(ageStr) ?? 0
                profile.weightKg = Double(weightStr) ?? 0
                profile.heightCm = Int(heightStr) ?? 0
                onNext()
            }
        }
        .padding(.horizontal, 24)
    }
}

struct OnboardingDaysStep: View {
    @Binding var days: Int
    let onFinish: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Text("¿Cuántos días a la semana?")
                .font(KhorFonts.displayMedium())
                .foregroundColor(KhorColors.textPrimary)
                .multilineTextAlignment(.center)

            HStack(spacing: 12) {
                ForEach(2...6, id: \.self) { n in
                    Button { days = n } label: {
                        Text("\(n)")
                            .font(KhorFonts.displayMedium())
                            .foregroundColor(days == n ? .white : KhorColors.textSecondary)
                            .frame(width: 52, height: 52)
                            .background(days == n ? KhorColors.accent : KhorColors.surface)
                            .cornerRadius(12)
                    }
                    .buttonStyle(.plain)
                }
            }

            KhorPrimaryButton(title: "¡Empezar!", disabled: days == 0, action: onFinish)
        }
        .padding(.horizontal, 24)
    }
}
