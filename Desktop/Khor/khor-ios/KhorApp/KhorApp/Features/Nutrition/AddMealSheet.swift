import SwiftUI

struct AddMealSheet: View {
    let onSave: (MealLog) -> Void
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var calories = ""
    @State private var protein = ""
    @State private var carbs = ""
    @State private var fat = ""
    @State private var mealType: MealType = .lunch
    @State private var showAiInput = false
    @State private var aiText = ""

    private var isValid: Bool {
        !name.isEmpty && Double(calories) != nil
    }

    var body: some View {
        NavigationStack {
            ZStack {
                KhorColors.background.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        // Meal type picker
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(MealType.allCases, id: \.self) { type in
                                    Button {
                                        mealType = type
                                    } label: {
                                        HStack(spacing: 6) {
                                            Text(type.emoji)
                                            Text(type.displayName)
                                                .font(KhorFonts.caption())
                                        }
                                        .foregroundColor(mealType == type ? .white : KhorColors.textSecondary)
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 8)
                                        .background(mealType == type ? KhorColors.accent : KhorColors.surface)
                                        .cornerRadius(20)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }

                        VStack(spacing: 14) {
                            KhorTextField(placeholder: "Nombre del alimento", text: $name)
                            HStack(spacing: 12) {
                                KhorTextField(placeholder: "Calorías", text: $calories, keyboardType: .numberPad)
                                KhorTextField(placeholder: "Proteína (g)", text: $protein, keyboardType: .numberPad)
                            }
                            HStack(spacing: 12) {
                                KhorTextField(placeholder: "Carbos (g)", text: $carbs, keyboardType: .numberPad)
                                KhorTextField(placeholder: "Grasas (g)", text: $fat, keyboardType: .numberPad)
                            }
                        }
                        .padding(.horizontal, 20)

                        KhorPrimaryButton(title: "Guardar comida", disabled: !isValid) {
                            let meal = MealLog(
                                date: Date(),
                                mealType: mealType,
                                name: name,
                                calories: Double(calories) ?? 0,
                                protein: Double(protein) ?? 0,
                                carbs: Double(carbs) ?? 0,
                                fat: Double(fat) ?? 0
                            )
                            onSave(meal)
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.top, 16)
                }
            }
            .navigationTitle("Añadir comida")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                        .foregroundColor(KhorColors.textSecondary)
                }
            }
        }
    }
}
