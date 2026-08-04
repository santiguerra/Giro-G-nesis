import SwiftUI

struct ForgotPasswordView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss

    @State private var email = ""
    @State private var sent = false

    var body: some View {
        ZStack {
            KhorColors.background.ignoresSafeArea()

            VStack(spacing: 24) {
                Text(sent ? "Correo enviado" : "Recuperar contraseña")
                    .font(KhorFonts.titleLarge())
                    .foregroundColor(KhorColors.textPrimary)
                    .padding(.top, 32)

                if sent {
                    VStack(spacing: 12) {
                        Image(systemName: "envelope.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(KhorColors.success)
                        Text("Revisa tu bandeja de entrada en \(email) para resetear tu contraseña.")
                            .font(KhorFonts.body())
                            .foregroundColor(KhorColors.textSecondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 24)
                } else {
                    VStack(spacing: 16) {
                        Text("Te enviaremos un enlace para resetear tu contraseña.")
                            .font(KhorFonts.body())
                            .foregroundColor(KhorColors.textSecondary)
                            .multilineTextAlignment(.center)

                        KhorTextField(placeholder: "Correo electrónico", text: $email, keyboardType: .emailAddress)
                            .padding(.horizontal, 24)

                        KhorPrimaryButton(title: "Enviar enlace", disabled: email.isEmpty) {
                            Task {
                                await authViewModel.sendPasswordReset(email: email)
                                sent = true
                            }
                        }
                        .padding(.horizontal, 24)
                    }
                }

                Button("Cerrar") { dismiss() }
                    .font(KhorFonts.body())
                    .foregroundColor(KhorColors.textTertiary)

                Spacer()
            }
        }
    }
}
