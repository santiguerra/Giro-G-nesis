import SwiftUI

struct AuthFlowView: View {
    @State private var showSignUp = false

    var body: some View {
        NavigationStack {
            if showSignUp {
                SignUpView(onBack: { showSignUp = false })
            } else {
                LoginView(onSignUp: { showSignUp = true })
            }
        }
    }
}
