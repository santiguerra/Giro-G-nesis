import Foundation

@MainActor
class NutritionViewModel: ObservableObject {
    @Published var todaySummary: DailyNutritionSummary?
    @Published var nutritionGoal: NutritionGoal?

    private let repository = NutritionRepository.shared

    func load() async {
        todaySummary = await repository.getTodaySummary()
        nutritionGoal = await repository.getNutritionGoal()
    }

    func addMeal(_ meal: MealLog) async {
        await repository.saveMeal(meal)
        await load()
    }

    func deleteMeal(_ meal: MealLog) async {
        await repository.deleteMeal(meal)
        await load()
    }
}
