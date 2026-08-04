import SwiftUI

struct KhorTextField: View {
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        TextField(placeholder, text: $text)
            .keyboardType(keyboardType)
            .autocapitalization(keyboardType == .emailAddress ? .none : .words)
            .autocorrectionDisabled()
            .font(KhorFonts.body())
            .foregroundColor(KhorColors.textPrimary)
            .padding(16)
            .background(KhorColors.surface)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(text.isEmpty ? KhorColors.surfaceMid : KhorColors.accent.opacity(0.6), lineWidth: 1)
            )
    }
}

struct KhorSecureField: View {
    let placeholder: String
    @Binding var text: String
    @State private var isVisible = false

    var body: some View {
        HStack {
            Group {
                if isVisible {
                    TextField(placeholder, text: $text)
                } else {
                    SecureField(placeholder, text: $text)
                }
            }
            .font(KhorFonts.body())
            .foregroundColor(KhorColors.textPrimary)
            .autocapitalization(.none)
            .autocorrectionDisabled()

            Button {
                isVisible.toggle()
            } label: {
                Image(systemName: isVisible ? "eye.slash" : "eye")
                    .foregroundColor(KhorColors.textTertiary)
            }
        }
        .padding(16)
        .background(KhorColors.surface)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(text.isEmpty ? KhorColors.surfaceMid : KhorColors.accent.opacity(0.6), lineWidth: 1)
        )
    }
}
