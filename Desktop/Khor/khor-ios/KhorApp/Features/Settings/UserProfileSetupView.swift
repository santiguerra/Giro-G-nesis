import SwiftUI

struct UserProfileSetupView: View {
    @State private var profile = UserProfile()

    var body: some View {
        ZStack {
            KhorColors.background.ignoresSafeArea()

            Form {
                Section("Información básica") {
                    TextField("Nombre", text: $profile.name)
                    Picker("Género", selection: $profile.gender) {
                        ForEach(Gender.allCases, id: \.self) { Text($0.displayName).tag($0) }
                    }
                    Stepper("Edad: \(profile.age) años", value: $profile.age, in: 14...100)
                }
                .listRowBackground(KhorColors.surface)
                .foregroundColor(KhorColors.textPrimary)

                Section("Medidas") {
                    HStack {
                        Text("Peso")
                        Spacer()
                        TextField("kg", value: $profile.weightKg, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Altura")
                        Spacer()
                        TextField("cm", value: $profile.heightCm, format: .number)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                }
                .listRowBackground(KhorColors.surface)
                .foregroundColor(KhorColors.textPrimary)

                Section("Entrenamiento") {
                    Picker("Nivel", selection: $profile.userLevel) {
                        ForEach(UserLevel.allCases, id: \.self) { Text($0.displayName).tag($0) }
                    }
                    Picker("Lugar", selection: $profile.trainingLocation) {
                        ForEach(TrainingLocation.allCases, id: \.self) { Text($0.displayName).tag($0) }
                    }
                    Stepper("Días/semana: \(profile.trainingDaysPerWeek)", value: $profile.trainingDaysPerWeek, in: 1...7)
                }
                .listRowBackground(KhorColors.surface)
                .foregroundColor(KhorColors.textPrimary)
            }
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("Mi perfil")
        .navigationBarTitleDisplayMode(.large)
    }
}
