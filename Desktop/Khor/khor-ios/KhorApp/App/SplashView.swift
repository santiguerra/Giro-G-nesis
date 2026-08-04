import SwiftUI

struct SplashView: View {
    @State private var scale: CGFloat = 0.8
    @State private var opacity: Double = 0

    var body: some View {
        ZStack {
            KhorColors.background.ignoresSafeArea()
            VStack(spacing: 16) {
                Text("KHOR")
                    .font(KhorFonts.displayLarge(56))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [KhorColors.accent, KhorColors.accentCyan],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .scaleEffect(scale)
                    .opacity(opacity)
                Text("AI FITNESS COACH")
                    .font(KhorFonts.label(13))
                    .foregroundColor(KhorColors.textTertiary)
                    .tracking(4)
                    .opacity(opacity)
            }
        }
        .onAppear {
            withAnimation(.spring(duration: 0.6)) {
                scale = 1.0
                opacity = 1.0
            }
        }
    }
}
