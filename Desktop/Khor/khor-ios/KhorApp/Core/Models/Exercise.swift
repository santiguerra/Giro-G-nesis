import Foundation

struct Exercise: Identifiable, Codable, Equatable {
    var id: String
    var name: String
    var nameEs: String?
    var muscleGroup: MuscleGroup
    var equipment: String?
    var instructions: String?
    var gifName: String?

    var displayName: String { nameEs ?? name }
}

enum MuscleGroup: String, Codable, CaseIterable {
    case chest = "CHEST"
    case back = "BACK"
    case shoulders = "SHOULDERS"
    case arms = "ARMS"
    case biceps = "BICEPS"
    case triceps = "TRICEPS"
    case core = "CORE"
    case legs = "LEGS"
    case glutes = "GLUTES"
    case calves = "CALVES"
    case cardio = "CARDIO"
    case fullBody = "FULL_BODY"

    var displayName: String {
        switch self {
        case .chest: return "Pecho"
        case .back: return "Espalda"
        case .shoulders: return "Hombros"
        case .arms: return "Brazos"
        case .biceps: return "Bíceps"
        case .triceps: return "Tríceps"
        case .core: return "Core"
        case .legs: return "Piernas"
        case .glutes: return "Glúteos"
        case .calves: return "Pantorrillas"
        case .cardio: return "Cardio"
        case .fullBody: return "Cuerpo completo"
        }
    }
}
