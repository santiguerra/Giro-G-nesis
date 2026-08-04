import SwiftUI

struct ProgressView: View {
    @StateObject private var viewModel = ProgressViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                KhorColors.background.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        // Weekly volume chart
                        WeeklyVolumeCard(data: viewModel.weeklyVolumeData)
                            .padding(.horizontal, 20)

                        // PRs section
                        if !viewModel.recentPRs.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Records personales recientes")
                                    .font(KhorFonts.titleMedium())
                                    .foregroundColor(KhorColors.textPrimary)
                                    .padding(.horizontal, 20)

                                ForEach(viewModel.recentPRs) { pr in
                                    PRRow(pr: pr)
                                        .padding(.horizontal, 20)
                                }
                            }
                        }

                        // Workout frequency heatmap placeholder
                        WorkoutFrequencyCard(workouts: viewModel.last30DaysWorkouts)
                            .padding(.horizontal, 20)

                        Spacer(minLength: 100)
                    }
                    .padding(.top, 16)
                }
            }
            .navigationTitle("Progreso")
            .navigationBarTitleDisplayMode(.large)
        }
        .task { await viewModel.load() }
    }
}

struct WeeklyVolumeCard: View {
    let data: [DayVolume]

    var maxVolume: Double { data.map { $0.volumeKg }.max() ?? 1 }

    var body: some View {
        KhorCard {
            VStack(alignment: .leading, spacing: 12) {
                Text("Volumen semanal")
                    .font(KhorFonts.titleMedium())
                    .foregroundColor(KhorColors.textPrimary)

                HStack(alignment: .bottom, spacing: 6) {
                    ForEach(data) { day in
                        VStack(spacing: 4) {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(day.volumeKg > 0
                                      ? LinearGradient(colors: [KhorColors.accent, KhorColors.accentViolet], startPoint: .bottom, endPoint: .top)
                                      : LinearGradient(colors: [KhorColors.surfaceMid, KhorColors.surfaceMid], startPoint: .top, endPoint: .bottom)
                                )
                                .frame(height: max(8, CGFloat(day.volumeKg / maxVolume) * 80))
                            Text(day.label)
                                .font(KhorFonts.label(9))
                                .foregroundColor(KhorColors.textTertiary)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .frame(height: 100)
            }
        }
    }
}

struct DayVolume: Identifiable {
    let id = UUID()
    let label: String
    let volumeKg: Double
}

struct PRRow: View {
    let pr: PersonalRecord

    var body: some View {
        KhorCard(padding: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(pr.exerciseName)
                        .font(KhorFonts.body())
                        .foregroundColor(KhorColors.textPrimary)
                    Text(pr.date.formatted(date: .abbreviated, time: .omitted))
                        .font(KhorFonts.label())
                        .foregroundColor(KhorColors.textTertiary)
                }
                Spacer()
                HStack(spacing: 4) {
                    Text("🏆")
                    Text("\(String(format: "%.1f", pr.weightKg)) kg × \(pr.reps)")
                        .font(KhorFonts.titleMedium())
                        .foregroundColor(KhorColors.warning)
                }
            }
        }
    }
}

struct WorkoutFrequencyCard: View {
    let workouts: [Date]

    var body: some View {
        KhorCard {
            VStack(alignment: .leading, spacing: 12) {
                Text("Frecuencia (30 días)")
                    .font(KhorFonts.titleMedium())
                    .foregroundColor(KhorColors.textPrimary)

                HStack(spacing: 4) {
                    ForEach(0..<30, id: \.self) { dayOffset in
                        let date = Calendar.current.date(byAdding: .day, value: -(29 - dayOffset), to: Date())!
                        let hasWorkout = workouts.contains { Calendar.current.isDate($0, inSameDayAs: date) }
                        RoundedRectangle(cornerRadius: 3)
                            .fill(hasWorkout ? KhorColors.accent : KhorColors.surfaceMid)
                            .frame(width: 8, height: 20)
                    }
                }
            }
        }
    }
}
