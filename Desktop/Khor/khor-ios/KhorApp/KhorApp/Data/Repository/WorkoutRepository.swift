import Foundation

actor WorkoutRepository {
    static let shared = WorkoutRepository()
    private init() {}

    private var workouts: [Workout] = []

    func getRecentWorkouts(limit: Int) async -> [Workout] {
        Array(workouts.sorted { $0.date > $1.date }.prefix(limit))
    }

    func getWorkoutsThisWeek() async -> [Workout] {
        let startOfWeek = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        return workouts.filter { $0.date >= startOfWeek }
    }

    func getWorkoutsLastDays(_ days: Int) async -> [Workout] {
        let cutoff = Calendar.current.date(byAdding: .day, value: -days, to: Date())!
        return workouts.filter { $0.date >= cutoff }
    }

    func saveWorkout(_ workout: Workout) async {
        if let index = workouts.firstIndex(where: { $0.id == workout.id }) {
            workouts[index] = workout
        } else {
            workouts.append(workout)
        }
    }

    func calculateStreak() async -> Int {
        let calendar = Calendar.current
        let sortedDates = workouts.map { calendar.startOfDay(for: $0.date) }
            .sorted(by: >)
            .removingDuplicates()

        guard let first = sortedDates.first,
              calendar.isDateInToday(first) || calendar.isDateInYesterday(first) else {
            return 0
        }

        var streak = 1
        var current = first
        for date in sortedDates.dropFirst() {
            if let expected = calendar.date(byAdding: .day, value: -1, to: current),
               calendar.isDate(date, inSameDayAs: expected) {
                streak += 1
                current = date
            } else {
                break
            }
        }
        return streak
    }
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}
