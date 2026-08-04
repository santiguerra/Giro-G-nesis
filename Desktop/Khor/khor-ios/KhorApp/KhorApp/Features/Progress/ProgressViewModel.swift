import Foundation

struct PersonalRecord: Identifiable {
    let id = UUID()
    let exerciseName: String
    let weightKg: Double
    let reps: Int
    let date: Date
}

@MainActor
class ProgressViewModel: ObservableObject {
    @Published var weeklyVolumeData: [DayVolume] = []
    @Published var recentPRs: [PersonalRecord] = []
    @Published var last30DaysWorkouts: [Date] = []

    private let workoutRepository = WorkoutRepository.shared

    func load() async {
        let workouts = await workoutRepository.getWorkoutsLastDays(30)
        last30DaysWorkouts = workouts.map { $0.date }

        weeklyVolumeData = buildWeeklyData(workouts: workouts)
    }

    private func buildWeeklyData(workouts: [Workout]) -> [DayVolume] {
        let calendar = Calendar.current
        let dayLabels = ["L", "M", "X", "J", "V", "S", "D"]
        return (0..<7).map { offset in
            let date = calendar.date(byAdding: .day, value: -(6 - offset), to: Date())!
            let vol = workouts
                .filter { calendar.isDate($0.date, inSameDayAs: date) }
                .compactMap { $0.summaryVolumeKg }
                .reduce(0, +)
            let weekday = calendar.component(.weekday, from: date)
            let labelIndex = (weekday + 5) % 7
            return DayVolume(label: dayLabels[labelIndex], volumeKg: vol)
        }
    }
}
