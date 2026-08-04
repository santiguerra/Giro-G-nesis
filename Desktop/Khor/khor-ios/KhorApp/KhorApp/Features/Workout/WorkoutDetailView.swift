import SwiftUI

struct WorkoutDetailView: View {
    let workout: Workout

    var body: some View {
        ZStack {
            KhorColors.background.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Header stats
                    HStack(spacing: 12) {
                        if let mins = workout.durationMinutes {
                            KhorStatCard(title: "Duración", value: "\(mins)", unit: "min", icon: "clock.fill")
                        }
                        if let vol = workout.summaryVolumeKg {
                            KhorStatCard(title: "Volumen", value: String(format: "%.0f", vol), unit: "kg", icon: "chart.bar.fill", accentColor: KhorColors.accentCyan)
                        }
                    }
                    .padding(.horizontal, 20)

                    // Exercises
                    ForEach(workout.exercises) { exercise in
                        KhorCard {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(exercise.exerciseName)
                                    .font(KhorFonts.titleMedium())
                                    .foregroundColor(KhorColors.textPrimary)

                                ForEach(exercise.sets) { set in
                                    HStack {
                                        Text("Serie \(set.setNumber)")
                                            .font(KhorFonts.caption())
                                            .foregroundColor(KhorColors.textTertiary)
                                        Spacer()
                                        Text("\(set.reps ?? 0) × \(String(format: "%.1f", set.weight))kg")
                                            .font(KhorFonts.body())
                                            .foregroundColor(KhorColors.textPrimary)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }

                    if let insight = workout.khorInsight {
                        MotivationCard(text: insight)
                            .padding(.horizontal, 20)
                    }

                    Spacer(minLength: 100)
                }
                .padding(.top, 16)
            }
        }
        .navigationTitle(workout.programName ?? "Entrenamiento")
        .navigationBarTitleDisplayMode(.large)
    }
}
