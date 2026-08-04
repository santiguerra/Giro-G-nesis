import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var onSignUp: () -> Void

    @State private var email = ""
    @State private var password = ""
    @State private var showForgotPassword = false

    var body: some View {
        ZStack {
            KhorColors.background.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 32) {
                    // Logo
                    VStack(spacing: 8) {
                        Text("KHOR")
                            .font(KhorFonts.displayLarge(48))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [KhorColors.accent, KhorColors.accentCyan],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        Text("Tu coach de fitness con IA")
                            .font(KhorFonts.body())
                            .foregroundColor(KhorColors.textTertiary)
                    }
                    .padding(.top, 60)

                    // Form
                    VStack(spacing: 16) {
                        KhorTextField(placeholder: "Correo electrónico", text: $email, keyboardType: .emailAddress)
                        KhorSecureField(placeholder: "Contraseña", text: $password)

                        Button("¿Olvidaste tu contraseña?") {
                            showForgotPassword = true
                        }
                        .font(KhorFonts.caption())
                        .foregroundColor(KhorColors.accent)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }

                    // Actions
                    VStack(spacing: 12) {
                        KhorPrimaryButton(title: "Iniciar Sesión") {
                            Task { await authViewModel.signIn(email: email, password: password) }
                        }

                        KhorDivider(label: "o continúa con")

                        GoogleSignInButton {
                            guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                  let root = scene.windows.first?.rootViewController else { return }
                            Task { await authViewModel.signInWithGoogle(presenting: root) }
                        }

                        Button(action: onSignUp) {
                            HStack(spacing: 4) {
                                Text("¿No tienes cuenta?")
                                    .foregroundColor(KhorColors.textSecondary)
                                Text("Regístrate")
                                    .foregroundColor(KhorColors.accent)
                                    .fontWeight(.semibold)
                            }
                            .font(KhorFonts.body())
                        }
                        .padding(.top, 8)
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
        .sheet(isPresented: $showForgotPassword) {
            ForgotPasswordView()
        }
    }
}
