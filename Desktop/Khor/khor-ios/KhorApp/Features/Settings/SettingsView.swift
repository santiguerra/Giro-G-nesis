import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        ZStack {
            KhorColors.background.ignoresSafeArea()

            List {
                Section {
                    HStack(spacing: 14) {
                        Circle()
                            .fill(LinearGradient(colors: [KhorColors.accent, KhorColors.accentViolet], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 56, height: 56)
                            .overlay(
                                Text(String(authViewModel.user?.displayName?.prefix(1) ?? "?"))
                                    .font(KhorFonts.displayMedium(24))
                                    .foregroundColor(.white)
                            )
                        VStack(alignment: .leading, spacing: 2) {
                            Text(authViewModel.user?.displayName ?? "Atleta")
                                .font(KhorFonts.titleMedium())
                                .foregroundColor(KhorColors.textPrimary)
                            Text(authViewModel.user?.email ?? "")
                                .font(KhorFonts.caption())
                                .foregroundColor(KhorColors.textTertiary)
                        }
                    }
                    .listRowBackground(KhorColors.surface)
                }

                Section("Perfil") {
                    NavigationLink(destination: UserProfileSetupView()) {
                        Label("Mi perfil", systemImage: "person.fill")
                    }
                    .listRowBackground(KhorColors.surface)
                    .foregroundColor(KhorColors.textPrimary)
                }

                Section("App") {
                    NavigationLink(destination: Text("Notificaciones").foregroundColor(KhorColors.textPrimary)) {
                        Label("Notificaciones", systemImage: "bell.fill")
                    }
                    .listRowBackground(KhorColors.surface)
                    .foregroundColor(KhorColors.textPrimary)

                    NavigationLink(destination: Text("Privacidad").foregroundColor(KhorColors.textPrimary)) {
                        Label("Privacidad", systemImage: "lock.fill")
                    }
                    .listRowBackground(KhorColors.surface)
                    .foregroundColor(KhorColors.textPrimary)
                }

                Section {
                    Button(role: .destructive) {
                        authViewModel.signOut()
                    } label: {
                        Label("Cerrar sesión", systemImage: "arrow.right.square")
                            .foregroundColor(KhorColors.error)
                    }
                    .listRowBackground(KhorColors.surface)
                }
            }
            .scrollContentBackground(.hidden)
            .background(KhorColors.background)
        }
        .navigationTitle("Ajustes")
        .navigationBarTitleDisplayMode(.large)
    }
}
