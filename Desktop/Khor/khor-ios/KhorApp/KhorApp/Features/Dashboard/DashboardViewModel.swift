import Foundation

@MainActor
class DashboardViewModel: ObservableObject {
    @Published var currentStreak: Int = 0
    @Published var workoutsThisWeek: Int = 0
    @Published var totalVolumeKg: Double = 0
    @Published var todayWorkout: Workout?
    @Published var dailyMotivation: String?

    private let workoutRepository = WorkoutRepository.shared

    var totalVolumeFormatted: String {
        if totalVolumeKg >= 1000 {
            return String(format: "%.1fk", totalVolumeKg / 1000)
        }
        return String(format: "%.0f", totalVolumeKg)
    }

    func load() async {
        let workouts = await workoutRepository.getWorkoutsThisWeek()
        workoutsThisWeek = workouts.count
        totalVolumeKg = workouts.compactMap { $0.summaryVolumeKg }.reduce(0, +)
        currentStreak = await workoutRepository.calculateStreak()

        let today = Calendar.current.startOfDay(for: Date())
        todayWorkout = workouts.first { Calendar.current.isDate($0.date, inSameDayAs: today) }

        dailyMotivation = motivations.randomElement()
    }

    private let motivations = [
        "La disciplina es el puente entre metas y logros.",
        "No busques la motivación. Busca el hábito.",
        "Cada repetición te acerca a quien quieres ser.",
        "El dolor de hoy es la fuerza de mañana.",
        "No pares cuando estés cansado. Para cuando estés listo."
    ]
}
