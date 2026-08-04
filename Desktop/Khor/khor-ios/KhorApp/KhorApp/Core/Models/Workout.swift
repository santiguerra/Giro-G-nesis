import Foundation

struct Workout: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var date: Date
    var startTime: Date?
    var endTime: Date?
    var notes: String?
    var programId: String?
    var programName: String?
    var day: Int?
    var sessionType: SessionType?
    var khorInsight: String?
    var summaryVolumeKg: Double?
    var completedSetsCount: Int?
    var exercises: [WorkoutExercise] = []

    var durationMinutes: Int? {
        guard let start = startTime, let end = endTime else { return nil }
        return Int(end.timeIntervalSince(start) / 60)
    }
}

struct WorkoutExercise: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var workoutId: UUID
    var exerciseId: String
    var exerciseName: String
    var order: Int
    var sets: [WorkoutSet] = []
}

struct WorkoutSet: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var workoutExerciseId: UUID
    var setNumber: Int
    var reps: Int?
    var weight: Double
    var isCompleted: Bool = false
    var restSeconds: Int?
    var notes: String?
    var setType: WorkoutSetType = .normal

    var countsTowardVolume: Bool {
        isCompleted && setType != .warmup
    }
}

enum WorkoutSetType: String, Codable, CaseIterable {
    case normal = "NORMAL"
    case warmup = "WARMUP"
    case dropSet = "DROP_SET"
    case failureSet = "FAILURE"

    var displayName: String {
        switch self {
        case .normal: return "Normal"
        case .warmup: return "Calentamiento"
        case .dropSet: return "Drop Set"
        case .failureSet: return "Al fallo"
        }
    }
}

enum SessionType: String, Codable, CaseIterable {
    case strength = "STRENGTH"
    case volume = "VOLUME"
    case accumulation = "ACCUMULATION"

    var displayName: String {
        switch self {
        case .strength: return "Fuerza"
        case .volume: return "Volumen"
        case .accumulation: return "Acumulación"
        }
    }
}
