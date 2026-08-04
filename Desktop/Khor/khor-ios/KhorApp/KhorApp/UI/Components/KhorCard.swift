import SwiftUI

struct KhorCard<Content: View>: View {
    var padding: CGFloat = 16
    @ViewBuilder let content: Content

    var body: some View {
        content
            .padding(padding)
            .background(KhorColors.surface)
            .cornerRadius(16)
    }
}

struct KhorStatCard: View {
    let title: String
    let value: String
    let unit: String?
    let icon: String
    var accentColor: Color = KhorColors.accent

    var body: some View {
        KhorCard {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: icon)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(accentColor)
                    Text(title)
                        .font(KhorFonts.caption())
                        .foregroundColor(KhorColors.textTertiary)
                }
                HStack(alignment: .lastTextBaseline, spacing: 4) {
                    Text(value)
                        .font(KhorFonts.displayMedium(28))
                        .foregroundColor(KhorColors.textPrimary)
                    if let unit {
                        Text(unit)
                            .font(KhorFonts.caption())
                            .foregroundColor(KhorColors.textSecondary)
                    }
                }
            }
        }
    }
}
