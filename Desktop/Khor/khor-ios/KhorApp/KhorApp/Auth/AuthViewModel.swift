import Foundation
import FirebaseAuth
import Combine

@MainActor
class AuthViewModel: ObservableObject {
    @Published var user: FirebaseAuth.User?
    @Published var isLoading: Bool = true
    @Published var error: String?

    private var handle: AuthStateDidChangeListenerHandle?

    init() {
        handle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            Task { @MainActor in
                self?.user = user
                self?.isLoading = false
            }
        }
    }

    deinit {
        if let handle { Auth.auth().removeStateDidChangeListener(handle) }
    }

    func signInWithGoogle(presenting: UIViewController) async {
        isLoading = true
        do {
            user = try await AuthService.shared.signInWithGoogle(presenting: presenting)
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }

    func signIn(email: String, password: String) async {
        isLoading = true
        do {
            user = try await AuthService.shared.signIn(email: email, password: password)
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }

    func signUp(email: String, password: String, name: String) async {
        isLoading = true
        do {
            user = try await AuthService.shared.signUp(email: email, password: password, name: name)
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }

    func sendPasswordReset(email: String) async {
        do {
            try await AuthService.shared.sendPasswordReset(email: email)
        } catch {
            self.error = error.localizedDescription
        }
    }

    func signOut() {
        do {
            try AuthService.shared.signOut()
            user = nil
        } catch {
            self.error = error.localizedDescription
        }
    }
}
