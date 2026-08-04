import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var onBack: () -> Void

    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    private var passwordsMatch: Bool { password == confirmPassword }
    private var isValid: Bool { !name.isEmpty && !email.isEmpty && password.count >= 6 && passwordsMatch }

    var body: some View {
        ZStack {
            KhorColors.background.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 28) {
                    VStack(spacing: 8) {
                        Text("Crear cuenta")
                            .font(KhorFonts.displayMedium())
                            .foregroundColor(KhorColors.textPrimary)
                        Text("Empieza tu transformación hoy")
                            .font(KhorFonts.body())
                            .foregroundColor(KhorColors.textTertiary)
                    }
                    .padding(.top, 40)

                    VStack(spacing: 16) {
                        KhorTextField(placeholder: "Nombre completo", text: $name)
                        KhorTextField(placeholder: "Correo electrónico", text: $email, keyboardType: .emailAddress)
                        KhorSecureField(placeholder: "Contraseña (mín. 6 caracteres)", text: $password)
                        KhorSecureField(placeholder: "Confirmar contraseña", text: $confirmPassword)

                        if !confirmPassword.isEmpty && !passwordsMatch {
                            Text("Las contraseñas no coinciden")
                                .font(KhorFonts.caption())
                                .foregroundColor(KhorColors.error)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }

                    KhorPrimaryButton(title: "Crear Cuenta", disabled: !isValid) {
                        Task { await authViewModel.signUp(email: email, password: password, name: name) }
                    }

                    Button(action: onBack) {
                        HStack(spacing: 4) {
                            Text("¿Ya tienes cuenta?")
                                .foregroundColor(KhorColors.textSecondary)
                            Text("Inicia sesión")
                                .foregroundColor(KhorColors.accent)
                                .fontWeight(.semibold)
                        }
                        .font(KhorFonts.body())
                    }

                    if let error = authViewModel.error {
                        Text(error)
                            .font(KhorFonts.caption())
                            .foregroundColor(KhorColors.error)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
    }
}
