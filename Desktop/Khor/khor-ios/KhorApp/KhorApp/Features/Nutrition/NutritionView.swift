import SwiftUI

struct NutritionView: View {
    @StateObject private var viewModel = NutritionViewModel()
    @State private var showAddMeal = false

    var body: some View {
        NavigationStack {
            ZStack {
                KhorColors.background.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 16) {
                        // Daily summary ring
                        NutritionRingCard(summary: viewModel.todaySummary, goal: viewModel.nutritionGoal)
                            .padding(.horizontal, 20)

                        // Macros bar
                        MacrosCard(summary: viewModel.todaySummary, goal: viewModel.nutritionGoal)
                            .padding(.horizontal, 20)

                        // Meals list
                        if let summary = viewModel.todaySummary, !summary.meals.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Comidas de hoy")
                                    .font(KhorFonts.titleMedium())
                                    .foregroundColor(KhorColors.textPrimary)
                                    .padding(.horizontal, 20)

                                ForEach(summary.meals) { meal in
                                    MealRow(meal: meal, onDelete: {
                                        Task { await viewModel.deleteMeal(meal) }
                                    })
                                    .padding(.horizontal, 20)
                                }
                            }
                        }

                        Spacer(minLength: 100)
                    }
                    .padding(.top, 16)
                }

                // FAB
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            showAddMeal = true
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 56, height: 56)
                                .background(
                                    LinearGradient(
                                        colors: [KhorColors.accent, KhorColors.accentViolet],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .clipShape(Circle())
                                .shadow(color: KhorColors.accent.opacity(0.4), radius: 8, x: 0, y: 4)
                        }
                        .padding(.trailing, 24)
                        .padding(.bottom, 24)
                    }
                }
            }
            .navigationTitle("Nutrición")
            .navigationBarTitleDisplayMode(.large)
        }
        .sheet(isPresented: $showAddMeal) {
            AddMealSheet(onSave: { meal in
                Task { await viewModel.addMeal(meal) }
                showAddMeal = false
            })
        }
        .task { await viewModel.load() }
    }
}

struct NutritionRingCard: View {
    let summary: DailyNutritionSummary?
    let goal: NutritionGoal?

    private var consumed: Double { summary?.totalCalories ?? 0 }
    private var target: Double { goal?.calories ?? 2000 }
    private var progress: Double { min(consumed / target, 1.0) }

    var body: some View {
        KhorCard {
            HStack(spacing: 20) {
                ZStack {
                    Circle()
                        .stroke(KhorColors.surfaceMid, lineWidth: 10)
                        .frame(width: 90, height: 90)
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(
                            LinearGradient(colors: [KhorColors.accent, KhorColors.accentCyan], startPoint: .leading, endPoint: .trailing),
                            style: StrokeStyle(lineWidth: 10, lineCap: .round)
                        )
                        .frame(width: 90, height: 90)
                        .rotationEffect(.degrees(-90))
                    VStack(spacing: 2) {
                        Text("\(Int(consumed))")
                            .font(KhorFonts.titleMedium())
                            .foregroundColor(KhorColors.textPrimary)
                        Text("kcal")
                            .font(KhorFonts.label())
                            .foregroundColor(KhorColors.textTertiary)
                    }
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Calorías hoy")
                        .font(KhorFonts.caption())
                        .foregroundColor(KhorColors.textTertiary)
                    Text("\(Int(consumed)) / \(Int(target)) kcal")
                        .font(KhorFonts.titleMedium())
                        .foregroundColor(KhorColors.textPrimary)
                    Text("\(Int(target - consumed)) restantes")
                        .font(KhorFonts.caption())
                        .foregroundColor(consumed < target ? KhorColors.success : KhorColors.warning)
                }
                Spacer()
            }
        }
    }
}

struct MacrosCard: View {
    let summary: DailyNutritionSummary?
    let goal: NutritionGoal?

    var body: some View {
        KhorCard {
            HStack(spacing: 0) {
                MacroColumn(
                    name: "Proteína",
                    value: summary?.totalProtein ?? 0,
                    target: goal?.protein ?? 150,
                    color: KhorColors.accentBlue,
                    unit: "g"
                )
                Divider().background(KhorColors.surfaceMid)
                MacroColumn(
                    name: "Carbos",
                    value: summary?.totalCarbs ?? 0,
                    target: goal?.carbs ?? 200,
                    color: KhorColors.warning,
                    unit: "g"
                )
                Divider().background(KhorColors.surfaceMid)
                MacroColumn(
                    name: "Grasas",
                    value: summary?.totalFat ?? 0,
                    target: goal?.fat ?? 65,
                    color: KhorColors.accentCyan,
                    unit: "g"
                )
            }
        }
    }
}

struct MacroColumn: View {
    let name: String
    let value: Double
    let target: Double
    let color: Color
    let unit: String

    var body: some View {
        VStack(spacing: 6) {
            Text(name)
                .font(KhorFonts.label())
                .foregroundColor(KhorColors.textTertiary)
            Text("\(Int(value))\(unit)")
                .font(KhorFonts.titleMedium())
                .foregroundColor(KhorColors.textPrimary)
            ProgressView(value: min(value / target, 1.0))
                .tint(color)
                .frame(width: 60)
            Text("/ \(Int(target))\(unit)")
                .font(.system(size: 9))
                .foregroundColor(KhorColors.textDisabled)
        }
        .frame(maxWidth: .infinity)
    }
}

struct MealRow: View {
    let meal: MealLog
    let onDelete: () -> Void

    var body: some View {
        KhorCard(padding: 12) {
            HStack(spacing: 12) {
                Text(meal.mealType.emoji)
                    .font(.system(size: 24))
                VStack(alignment: .leading, spacing: 2) {
                    Text(meal.name)
                        .font(KhorFonts.body())
                        .foregroundColor(KhorColors.textPrimary)
                    Text(meal.mealType.displayName)
                        .font(KhorFonts.label())
                        .foregroundColor(KhorColors.textTertiary)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 2) {
                    Text("\(Int(meal.calories)) kcal")
                        .font(KhorFonts.body())
                        .foregroundColor(KhorColors.textPrimary)
                    Text("\(Int(meal.protein))g P")
                        .font(KhorFonts.label())
                        .foregroundColor(KhorColors.accentBlue)
                }
                Button(action: onDelete) {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(KhorColors.textDisabled)
                }
            }
        }
    }
}
