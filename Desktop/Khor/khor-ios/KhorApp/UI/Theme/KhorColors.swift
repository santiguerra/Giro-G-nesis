import SwiftUI

enum KhorColors {
    // Backgrounds
    static let background     = Color(hex: "0D0D0D")
    static let surface        = Color(hex: "1A1A1A")
    static let surfaceElevated = Color(hex: "262626")
    static let surfaceMid     = Color(hex: "333333")

    // Accent
    static let accent         = Color(hex: "8B5CF6")  // IronPurple
    static let accentViolet   = Color(hex: "7C3AED")
    static let accentElectric = Color(hex: "D500F9")
    static let accentBlue     = Color(hex: "3B82F6")
    static let accentCyan     = Color(hex: "06B6D4")
    static let accentIndigo   = Color(hex: "6366F1")

    // Status
    static let success        = Color(hex: "10B981")
    static let warning        = Color(hex: "F59E0B")
    static let error          = Color(hex: "EF4444")

    // Text
    static let textPrimary    = Color(hex: "F9FAFB")
    static let textSecondary  = Color(hex: "D1D5DB")
    static let textTertiary   = Color(hex: "9CA3AF")
    static let textDisabled   = Color(hex: "6B7280")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: Double
        switch hex.count {
        case 6:
            r = Double((int >> 16) & 0xFF) / 255
            g = Double((int >> 8) & 0xFF) / 255
            b = Double(int & 0xFF) / 255
        default:
            r = 1; g = 1; b = 1
        }
        self.init(red: r, green: g, blue: b)
    }
}
