import SwiftUI

struct ActiveWorkoutView: View {
    @ObservedObject var viewModel: WorkoutViewModel
    @State private var showExercisePicker = false
    @State private var showEndDialog = false
    @State private var sessionNotes = ""

    var body: some View {
        VStack(spacing: 0) {
            // Timer header
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(viewModel.activeSession?.programName ?? "Sesión libre")
                        .font(KhorFonts.titleMedium())
                        .foregroundColor(KhorColors.textPrimary)
                    Text(elapsedTimeString)
                        .font(KhorFonts.displayMedium())
                        .foregroundColor(KhorColors.accent)
                        .monospacedDigit()
                }
                Spacer()
                Button {
                    showEndDialog = true
                } label: {
                    Text("Terminar")
                        .font(KhorFonts.caption())
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(KhorColors.error)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(KhorColors.surface)

            ScrollView {
                VStack(spacing: 12) {
                    ForEach(Array((viewModel.activeSession?.exercises ?? []).enumerated()), id: \.element.id) { index, exercise in
                        ExerciseSessionCard(
                            exercise: exercise,
                            onLogSet: { reps, weight in
                                viewModel.logSet(exerciseIndex: index, reps: reps, weight: weight)
                            }
                        )
                    }

                    Button {
                        showExercisePicker = true
                    } label: {
                        Label("Añadir ejercicio", systemImage: "plus.circle.fill")
                            .font(KhorFonts.titleMedium())
                            .foregroundColor(KhorColors.accent)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(KhorColors.surface)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(KhorColors.accent.opacity(0.4), lineWidth: 1)
                            )
                    }
                    .padding(.horizontal, 20)

                    Spacer(minLength: 100)
                }
                .padding(.top, 12)
            }
        }
        .sheet(isPresented: $showExercisePicker) {
            ExercisePickerView(onSelect: { exercise in
                viewModel.addExercise(exercise)
                showExercisePicker = false
            })
        }
        .alert("Terminar sesión", isPresented: $showEndDialog) {
            TextField("Notas (opcional)", text: $sessionNotes)
            Button("Guardar sesión") {
                Task { await viewModel.endSession(notes: sessionNotes.isEmpty ? nil : sessionNotes) }
            }
            Button("Cancelar", role: .cancel) {}
        }
    }

    private var elapsedTimeString: String {
        let h = viewModel.elapsedSeconds / 3600
        let m = (viewModel.elapsedSeconds % 3600) / 60
        let s = viewModel.elapsedSeconds % 60
        if h > 0 {
            return String(format: "%d:%02d:%02d", h, m, s)
        }
        return String(format: "%02d:%02d", m, s)
    }
}

struct ExerciseSessionCard: View {
    let exercise: WorkoutExercise
    let onLogSet: (Int?, Double) -> Void
    @State private var reps: String = ""
    @State private var weight: String = ""

    var body: some View {
        KhorCard {
            VStack(alignment: .leading, spacing: 12) {
                Text(exercise.exerciseName)
                    .font(KhorFonts.titleMedium())
                    .foregroundColor(KhorColors.textPrimary)

                // Logged sets
                ForEach(exercise.sets) { set in
                    HStack {
                        Text("Serie \(set.setNumber)")
                            .font(KhorFonts.caption())
                            .foregroundColor(KhorColors.textTertiary)
                        Spacer()
                        Text("\(set.reps ?? 0) reps × \(String(format: "%.1f", set.weight)) kg")
                            .font(KhorFonts.body())
                            .foregroundColor(KhorColors.textPrimary)
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(KhorColors.success)
                    }
                }

                // Input row
                HStack(spacing: 8) {
                    TextField("Reps", text: $reps)
                        .keyboardType(.numberPad)
                        .padding(10)
                        .background(KhorColors.surfaceMid)
                        .cornerRadius(8)
                        .font(KhorFonts.body())
                        .foregroundColor(KhorColors.textPrimary)

                    TextField("Peso (kg)", text: $weight)
                        .keyboardType(.decimalPad)
                        .padding(10)
                        .background(KhorColors.surfaceMid)
                        .cornerRadius(8)
                        .font(KhorFonts.body())
                        .foregroundColor(KhorColors.textPrimary)

                    Button {
                        onLogSet(Int(reps), Double(weight) ?? 0)
                        reps = ""
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(KhorColors.accent)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
}
