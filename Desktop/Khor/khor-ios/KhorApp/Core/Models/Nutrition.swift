import Foundation

struct MealLog: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var date: Date
    var mealType: MealType
    var name: String
    var calories: Double
    var protein: Double
    var carbs: Double
    var fat: Double
    var notes: String?
    var source: MealSource = .manual
}

enum MealType: String, Codable, CaseIterable {
    case breakfast = "BREAKFAST"
    case lunch = "LUNCH"
    case dinner = "DINNER"
    case snack = "SNACK"
    case preworkout = "PRE_WORKOUT"
    case postworkout = "POST_WORKOUT"

    var displayName: String {
        switch self {
        case .breakfast: return "Desayuno"
        case .lunch: return "Almuerzo"
        case .dinner: return "Cena"
        case .snack: return "Snack"
        case .preworkout: return "Pre-Entreno"
        case .postworkout: return "Post-Entreno"
        }
    }

    var emoji: String {
        switch self {
        case .breakfast: return "🌅"
        case .lunch: return "☀️"
        case .dinner: return "🌙"
        case .snack: return "🍎"
        case .preworkout: return "⚡️"
        case .postworkout: return "💪"
        }
    }
}

enum MealSource: String, Codable {
    case manual = "MANUAL"
    case photo = "PHOTO"
    case voice = "VOICE"
    case ai = "AI"
}

struct NutritionGoal: Codable, Equatable {
    var calories: Double
    var protein: Double
    var carbs: Double
    var fat: Double
}

struct DailyNutritionSummary: Codable, Equatable {
    var date: Date
    var totalCalories: Double
    var totalProtein: Double
    var totalCarbs: Double
    var totalFat: Double
    var meals: [MealLog]

    var remainingCalories: Double { max(0, (goal?.calories ?? 2000) - totalCalories) }
    var goal: NutritionGoal?
}
