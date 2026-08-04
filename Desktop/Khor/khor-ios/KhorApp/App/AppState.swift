import Foundation
import Combine

class AppState: ObservableObject {
    @Published var isOnboardingComplete: Bool = false
    @Published var selectedTab: Tab = .dashboard

    enum Tab: Int, CaseIterable {
        case dashboard, workout, coach, nutrition, progress
    }
}
