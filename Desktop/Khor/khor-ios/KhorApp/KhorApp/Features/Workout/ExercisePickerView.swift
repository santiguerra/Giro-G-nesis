import SwiftUI

struct ExercisePickerView: View {
    let onSelect: (Exercise) -> Void
    @Environment(\.dismiss) var dismiss
    @State private var search = ""

    private var filtered: [Exercise] {
        if search.isEmpty { return mockExercises }
        return mockExercises.filter { $0.displayName.localizedCaseInsensitiveContains(search) }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                KhorColors.background.ignoresSafeArea()
                List(filtered) { exercise in
                    Button {
                        onSelect(exercise)
                        dismiss()
                    } label: {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(exercise.displayName)
                                .font(KhorFonts.body())
                                .foregroundColor(KhorColors.textPrimary)
                            Text(exercise.muscleGroup.displayName)
                                .font(KhorFonts.label())
                                .foregroundColor(KhorColors.textTertiary)
                        }
                    }
                    .listRowBackground(KhorColors.surface)
                }
                .scrollContentBackground(.hidden)
                .searchable(text: $search, prompt: "Buscar ejercicio")
            }
            .navigationTitle("Ejercicios")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                        .foregroundColor(KhorColors.textSecondary)
                }
            }
        }
    }

    private let mockExercises: [Exercise] = [
        Exercise(id: "bench_press", name: "Bench Press", nameEs: "Press de banca", muscleGroup: .chest),
        Exercise(id: "squat", name: "Squat", nameEs: "Sentadilla", muscleGroup: .legs),
        Exercise(id: "deadlift", name: "Deadlift", nameEs: "Peso muerto", muscleGroup: .back),
        Exercise(id: "ohp", name: "Overhead Press", nameEs: "Press militar", muscleGroup: .shoulders),
        Exercise(id: "pull_up", name: "Pull Up", nameEs: "Dominadas", muscleGroup: .back),
        Exercise(id: "row", name: "Barbell Row", nameEs: "Remo con barra", muscleGroup: .back),
        Exercise(id: "curl", name: "Bicep Curl", nameEs: "Curl de bíceps", muscleGroup: .biceps),
        Exercise(id: "tricep_dip", name: "Tricep Dip", nameEs: "Fondos de tríceps", muscleGroup: .triceps),
        Exercise(id: "lunge", name: "Lunge", nameEs: "Zancada", muscleGroup: .legs),
        Exercise(id: "plank", name: "Plank", nameEs: "Plancha", muscleGroup: .core),
    ]
}

struct QuickSessionChooserSheet: View {
    let onSelect: (WorkoutPlanSummary?) -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                KhorColors.background.ignoresSafeArea()
                VStack(spacing: 16) {
                    Button {
                        onSelect(nil)
                        dismiss()
                    } label: {
                        HStack {
                            Label("Sesión libre", systemImage: "figure.strengthtraining.traditional")
                                .font(KhorFonts.titleMedium())
                                .foregroundColor(KhorColors.textPrimary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(KhorColors.textDisabled)
                        }
                        .padding()
                        .background(KhorColors.surface)
                        .cornerRadius(14)
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, 20)

                    Spacer()
                }
                .padding(.top, 20)
            }
            .navigationTitle("Nueva sesión")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                        .foregroundColor(KhorColors.textSecondary)
                }
            }
        }
    }
}

struct WorkoutPlanSummary: Identifiable {
    let id: String
    let name: String
}
