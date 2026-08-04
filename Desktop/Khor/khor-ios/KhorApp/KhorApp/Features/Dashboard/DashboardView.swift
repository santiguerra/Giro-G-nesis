import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var viewModel = DashboardViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                KhorColors.background.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Greeting
                        VStack(alignment: .leading, spacing: 4) {
                            Text(greetingText)
                                .font(KhorFonts.titleMedium())
                                .foregroundColor(KhorColors.textTertiary)
                            Text(authViewModel.user?.displayName ?? "Atleta")
                                .font(KhorFonts.displayMedium())
                                .foregroundColor(KhorColors.textPrimary)
                        }
                        .padding(.horizontal, 20)

                        // Streak banner
                        if viewModel.currentStreak > 0 {
                            StreakBannerCard(streak: viewModel.currentStreak)
                                .padding(.horizontal, 20)
                        }

                        // Quick stats
                        HStack(spacing: 12) {
                            KhorStatCard(
                                title: "Esta semana",
                                value: "\(viewModel.workoutsThisWeek)",
                                unit: "entrenos",
                                icon: "dumbbell.fill",
                                accentColor: KhorColors.accent
                            )
                            KhorStatCard(
                                title: "Volumen",
                                value: viewModel.totalVolumeFormatted,
                                unit: "kg",
                                icon: "chart.bar.fill",
                                accentColor: KhorColors.accentCyan
                            )
                        }
                        .padding(.horizontal, 20)

                        // Today's workout
                        if let workout = viewModel.todayWorkout {
                            TodayWorkoutCard(workout: workout)
                                .padding(.horizontal, 20)
                        } else {
                            StartWorkoutCard()
                                .padding(.horizontal, 20)
                        }

                        // Motivation card
                        if let motivation = viewModel.dailyMotivation {
                            MotivationCard(text: motivation)
                                .padding(.horizontal, 20)
                        }

                        Spacer(minLength: 100)
                    }
                    .padding(.top, 16)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape")
                            .foregroundColor(KhorColors.textSecondary)
                    }
                }
            }
        }
        .task { await viewModel.load() }
    }

    private var greetingText: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 6..<12: return "Buenos días,"
        case 12..<18: return "Buenas tardes,"
        case 18..<22: return "Buenas noches,"
        default: return "Hola,"
        }
    }
}

struct StreakBannerCard: View {
    let streak: Int

    var body: some View {
        KhorCard {
            HStack(spacing: 12) {
                Text("🔥")
                    .font(.system(size: 28))
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(streak) días de racha")
                        .font(KhorFonts.titleMedium())
                        .foregroundColor(KhorColors.textPrimary)
                    Text("¡Sigue así! No rompas la cadena.")
                        .font(KhorFonts.caption())
                        .foregroundColor(KhorColors.textSecondary)
                }
                Spacer()
            }
        }
    }
}

struct TodayWorkoutCard: View {
    let workout: Workout

    var body: some View {
        KhorCard {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Label("Sesión de hoy", systemImage: "checkmark.circle.fill")
                        .font(KhorFonts.caption())
                        .foregroundColor(KhorColors.success)
                    Spacer()
                    if let mins = workout.durationMinutes {
                        Text("\(mins) min")
                            .font(KhorFonts.caption())
                            .foregroundColor(KhorColors.textTertiary)
                    }
                }
                Text(workout.programName ?? "Entrenamiento libre")
                    .font(KhorFonts.titleMedium())
                    .foregroundColor(KhorColors.textPrimary)
                Text("\(workout.completedSetsCount ?? 0) series completadas")
                    .font(KhorFonts.body())
                    .foregroundColor(KhorColors.textSecondary)
            }
        }
    }
}

struct StartWorkoutCard: View {
    var body: some View {
        NavigationLink(destination: WorkoutView()) {
            KhorCard {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("¿Listo para entrenar?")
                            .font(KhorFonts.titleMedium())
                            .foregroundColor(KhorColors.textPrimary)
                        Text("Empieza una sesión ahora")
                            .font(KhorFonts.caption())
                            .foregroundColor(KhorColors.textSecondary)
                    }
                    Spacer()
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 36))
                        .foregroundColor(KhorColors.accent)
                }
            }
        }
        .buttonStyle(.plain)
    }
}

struct MotivationCard: View {
    let text: String

    var body: some View {
        KhorCard {
            VStack(alignment: .leading, spacing: 8) {
                Label("Khor dice", systemImage: "bolt.fill")
                    .font(KhorFonts.caption())
                    .foregroundColor(KhorColors.accent)
                Text(text)
                    .font(KhorFonts.body())
                    .foregroundColor(KhorColors.textSecondary)
                    .italic()
            }
        }
    }
}
