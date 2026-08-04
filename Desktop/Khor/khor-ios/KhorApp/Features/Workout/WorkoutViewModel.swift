import Foundation

@MainActor
class WorkoutViewModel: ObservableObject {
    @Published var recentWorkouts: [Workout] = []
    @Published var activeSession: Workout?
    @Published var elapsedSeconds: Int = 0

    private let repository = WorkoutRepository.shared
    private var timer: Task<Void, Never>?

    func load() async {
        recentWorkouts = await repository.getRecentWorkouts(limit: 10)
    }

    func startSession(plan: WorkoutPlanSummary?) {
        let workout = Workout(
            date: Date(),
            startTime: Date(),
            programName: plan?.name
        )
        activeSession = workout
        startTimer()
    }

    func endSession(notes: String?) async {
        guard var workout = activeSession else { return }
        workout.endTime = Date()
        workout.notes = notes
        workout.summaryVolumeKg = calculateVolume(workout: workout)
        workout.completedSetsCount = workout.exercises.flatMap { $0.sets }.filter { $0.isCompleted }.count
        await repository.saveWorkout(workout)
        activeSession = nil
        timer?.cancel()
        elapsedSeconds = 0
        await load()
    }

    func addExercise(_ exercise: Exercise) {
        guard var session = activeSession else { return }
        let we = WorkoutExercise(
            workoutId: session.id,
            exerciseId: exercise.id,
            exerciseName: exercise.displayName,
            order: session.exercises.count
        )
        session.exercises.append(we)
        activeSession = session
    }

    func logSet(exerciseIndex: Int, reps: Int?, weight: Double, type: WorkoutSetType = .normal) {
        guard var session = activeSession else { return }
        let setNumber = session.exercises[exerciseIndex].sets.count + 1
        let set = WorkoutSet(
            workoutExerciseId: session.exercises[exerciseIndex].id,
            setNumber: setNumber,
            reps: reps,
            weight: weight,
            isCompleted: true,
            setType: type
        )
        session.exercises[exerciseIndex].sets.append(set)
        activeSession = session
    }

    private func calculateVolume(workout: Workout) -> Double {
        workout.exercises
            .flatMap { $0.sets }
            .filter { $0.countsTowardVolume }
            .reduce(0) { $0 + (Double($1.reps ?? 0) * $1.weight) }
    }

    private func startTimer() {
        timer = Task {
            while !Task.isCancelled {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                elapsedSeconds += 1
            }
        }
    }
}
