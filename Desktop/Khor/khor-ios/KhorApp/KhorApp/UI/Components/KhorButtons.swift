import SwiftUI

struct KhorPrimaryButton: View {
    let title: String
    var disabled: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(KhorFonts.titleMedium())
                .foregroundColor(disabled ? KhorColors.textDisabled : .white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    disabled
                    ? KhorColors.surfaceMid
                    : LinearGradient(
                        colors: [KhorColors.accent, KhorColors.accentViolet],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(14)
        }
        .disabled(disabled)
    }
}

struct KhorSecondaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(KhorFonts.titleMedium())
                .foregroundColor(KhorColors.accent)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(KhorColors.surface)
                .cornerRadius(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(KhorColors.accent, lineWidth: 1.5)
                )
        }
    }
}

struct GoogleSignInButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: "globe")
                    .font(.system(size: 18, weight: .medium))
                Text("Continuar con Google")
                    .font(KhorFonts.titleMedium())
            }
            .foregroundColor(KhorColors.textPrimary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(KhorColors.surface)
            .cornerRadius(14)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(KhorColors.surfaceMid, lineWidth: 1)
            )
        }
    }
}

struct KhorDivider: View {
    let label: String

    var body: some View {
        HStack(spacing: 12) {
            Rectangle().fill(KhorColors.surfaceMid).frame(height: 1)
            Text(label)
                .font(KhorFonts.caption())
                .foregroundColor(KhorColors.textTertiary)
                .fixedSize()
            Rectangle().fill(KhorColors.surfaceMid).frame(height: 1)
        }
    }
}
