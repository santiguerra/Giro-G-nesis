import Foundation

actor NutritionRepository {
    static let shared = NutritionRepository()
    private init() {}

    private var meals: [MealLog] = []
    private var goal: NutritionGoal = NutritionGoal(calories: 2000, protein: 150, carbs: 200, fat: 65)

    func getTodaySummary() async -> DailyNutritionSummary? {
        let today = Calendar.current.startOfDay(for: Date())
        let todayMeals = meals.filter { Calendar.current.isDate($0.date, inSameDayAs: today) }
        guard !todayMeals.isEmpty else { return nil }

        return DailyNutritionSummary(
            date: today,
            totalCalories: todayMeals.reduce(0) { $0 + $1.calories },
            totalProtein: todayMeals.reduce(0) { $0 + $1.protein },
            totalCarbs: todayMeals.reduce(0) { $0 + $1.carbs },
            totalFat: todayMeals.reduce(0) { $0 + $1.fat },
            meals: todayMeals,
            goal: goal
        )
    }

    func getNutritionGoal() async -> NutritionGoal { goal }

    func saveMeal(_ meal: MealLog) async {
        meals.append(meal)
    }

    func deleteMeal(_ meal: MealLog) async {
        meals.removeAll { $0.id == meal.id }
    }
}
