import Foundation

struct UserProfile: Codable, Equatable {
    var name: String = ""
    var gender: Gender = .notSpecified
    var age: Int = 0
    var weightKg: Double = 0
    var heightCm: Int = 0
    var fitnessGoal: FitnessGoal = .maintain
    var fitnessGoals: [FitnessGoal] = []
    var activityLevel: ActivityLevel = .moderate
    var trainingLocation: TrainingLocation = .gym
    var userLevel: UserLevel = .novice
    var trainingDaysPerWeek: Int = 0
    var injuryNotes: String = ""
    var specificGoal: String = ""
    var availableEquipment: EquipmentLevel = .fullGym
    var timeAvailableMinutes: Int = 45

    var bmi: Double? {
        guard weightKg > 0, heightCm > 0 else { return nil }
        let heightM = Double(heightCm) / 100
        return weightKg / (heightM * heightM)
    }

    var isComplete: Bool {
        gender != .notSpecified && age > 0 && weightKg > 0 && heightCm > 0
    }
}

enum Gender: String, Codable, CaseIterable {
    case male = "MALE"
    case female = "FEMALE"
    case notSpecified = "NOT_SPECIFIED"

    var displayName: String {
        switch self {
        case .male: return "Masculino"
        case .female: return "Femenino"
        case .notSpecified: return "No especificado"
        }
    }
}

enum FitnessGoal: String, Codable, CaseIterable {
    case loseFat = "LOSE_FAT"
    case gainMuscle = "GAIN_MUSCLE"
    case buildStrength = "BUILD_STRENGTH"
    case maintain = "MAINTAIN"
    case improveEndurance = "IMPROVE_ENDURANCE"

    var displayName: String {
        switch self {
        case .loseFat: return "Perder grasa"
        case .gainMuscle: return "Ganar músculo"
        case .buildStrength: return "Fuerza máxima"
        case .maintain: return "Mantenimiento"
        case .improveEndurance: return "Mejorar resistencia"
        }
    }

    var emoji: String {
        switch self {
        case .loseFat: return "🔥"
        case .gainMuscle: return "💪"
        case .buildStrength: return "⚡️"
        case .maintain: return "⚖️"
        case .improveEndurance: return "🏃"
        }
    }
}

enum ActivityLevel: String, Codable, CaseIterable {
    case sedentary = "SEDENTARY"
    case light = "LIGHT"
    case moderate = "MODERATE"
    case veryActive = "VERY_ACTIVE"
    case athlete = "ATHLETE"

    var displayName: String {
        switch self {
        case .sedentary: return "Sedentario"
        case .light: return "Ligeramente activo"
        case .moderate: return "Moderadamente activo"
        case .veryActive: return "Muy activo"
        case .athlete: return "Atleta"
        }
    }

    var multiplier: Double {
        switch self {
        case .sedentary: return 1.2
        case .light: return 1.375
        case .moderate: return 1.55
        case .veryActive: return 1.725
        case .athlete: return 1.9
        }
    }
}

enum TrainingLocation: String, Codable, CaseIterable {
    case gym = "GYM"
    case home = "HOME"
    case outdoor = "OUTDOOR"
    case hybrid = "HYBRID"

    var displayName: String {
        switch self {
        case .gym: return "Gimnasio"
        case .home: return "Casa"
        case .outdoor: return "Al aire libre"
        case .hybrid: return "Híbrido"
        }
    }
}

enum UserLevel: String, Codable, CaseIterable {
    case novice = "NOVICE"
    case intermediate = "INTERMEDIATE"
    case expert = "EXPERT"

    var displayName: String {
        switch self {
        case .novice: return "Novato"
        case .intermediate: return "Intermedio"
        case .expert: return "Experto"
        }
    }

    var toneInstruction: String {
        switch self {
        case .novice: return "Usa un tono suave, explicativo e inspirador. Sé un mentor paciente."
        case .intermediate: return "Usa un tono directo, rudo y disciplinado. No toleres excusas."
        case .expert: return "Usa un tono autoritario, extremadamente exigente y frío. Solo resultados."
        }
    }
}

enum EquipmentLevel: String, Codable, CaseIterable {
    case fullGym = "FULL_GYM"
    case homeBasic = "HOME_BASIC"
    case bodyweight = "BODYWEIGHT"

    var displayName: String {
        switch self {
        case .fullGym: return "Gimnasio completo"
        case .homeBasic: return "Casa (equipo básico)"
        case .bodyweight: return "Solo peso corporal"
        }
    }
}
