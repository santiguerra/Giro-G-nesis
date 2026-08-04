import SwiftUI

struct WorkoutView: View {
    @StateObject private var viewModel = WorkoutViewModel()
    @State private var showNewSession = false

    var body: some View {
        NavigationStack {
            ZStack {
                KhorColors.background.ignoresSafeArea()

                if viewModel.activeSession != nil {
                    ActiveWorkoutView(viewModel: viewModel)
                } else {
                    WorkoutHomeView(
                        recentWorkouts: viewModel.recentWorkouts,
                        onStart: { showNewSession = true }
                    )
                }
            }
            .navigationTitle("Workout")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .sheet(isPresented: $showNewSession) {
            QuickSessionChooserSheet(onSelect: { plan in
                viewModel.startSession(plan: plan)
                showNewSession = false
            })
        }
        .task { await viewModel.load() }
    }
}

struct WorkoutHomeView: View {
    let recentWorkouts: [Workout]
    let onStart: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Start button
                Button(action: onStart) {
                    HStack {
                        Image(systemName: "play.fill")
                        Text("Nueva Sesión")
                            .font(KhorFonts.titleMedium())
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(
                        LinearGradient(
                            colors: [KhorColors.accent, KhorColors.accentViolet],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(16)
                }
                .padding(.horizontal, 20)

                if !recentWorkouts.isEmpty {
                    Text("Sesiones recientes")
                        .font(KhorFonts.titleMedium())
                        .foregroundColor(KhorColors.textPrimary)
                        .padding(.horizontal, 20)

                    ForEach(recentWorkouts) { workout in
                        NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                            WorkoutHistoryRow(workout: workout)
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal, 20)
                    }
                }

                Spacer(minLength: 100)
            }
            .padding(.top, 16)
        }
    }
}

struct WorkoutHistoryRow: View {
    let workout: Workout

    var body: some View {
        KhorCard {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(workout.programName ?? "Entreno libre")
                        .font(KhorFonts.titleMedium())
                        .foregroundColor(KhorColors.textPrimary)
                    Text(workout.date.formatted(date: .abbreviated, time: .omitted))
                        .font(KhorFonts.caption())
                        .foregroundColor(KhorColors.textTertiary)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    if let vol = workout.summaryVolumeKg {
                        Text("\(Int(vol)) kg")
                            .font(KhorFonts.titleMedium())
                            .foregroundColor(KhorColors.accent)
                    }
                    if let mins = workout.durationMinutes {
                        Text("\(mins) min")
                            .font(KhorFonts.caption())
                            .foregroundColor(KhorColors.textTertiary)
                    }
                }
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(KhorColors.textDisabled)
            }
        }
    }
}
