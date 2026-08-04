import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        TabView(selection: $appState.selectedTab) {
            DashboardView()
                .tabItem { Label("Dashboard", systemImage: "house.fill") }
                .tag(AppState.Tab.dashboard)

            WorkoutView()
                .tabItem { Label("Workout", systemImage: "dumbbell.fill") }
                .tag(AppState.Tab.workout)

            CoachView()
                .tabItem { Label("Khor", systemImage: "bolt.fill") }
                .tag(AppState.Tab.coach)

            NutritionView()
                .tabItem { Label("Nutrición", systemImage: "fork.knife") }
                .tag(AppState.Tab.nutrition)

            ProgressView()
                .tabItem { Label("Progreso", systemImage: "chart.line.uptrend.xyaxis") }
                .tag(AppState.Tab.progress)
        }
        .tint(KhorColors.accent)
        .background(KhorColors.background)
    }
}
