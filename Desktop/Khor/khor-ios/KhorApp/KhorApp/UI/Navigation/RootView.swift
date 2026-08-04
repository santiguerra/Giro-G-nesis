import SwiftUI

struct RootView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var appState: AppState

    var body: some View {
        Group {
            if authViewModel.isLoading {
                SplashView()
            } else if authViewModel.user == nil {
                AuthFlowView()
            } else if !appState.isOnboardingComplete {
                OnboardingView()
            } else {
                MainTabView()
            }
        }
        .animation(.easeInOut(duration: 0.3), value: authViewModel.user?.uid)
    }
}
