import SwiftUI

enum KhorFonts {
    static func displayLarge(_ size: CGFloat = 32) -> Font { .system(size: size, weight: .black, design: .rounded) }
    static func displayMedium(_ size: CGFloat = 24) -> Font { .system(size: size, weight: .bold, design: .rounded) }
    static func titleLarge(_ size: CGFloat = 20) -> Font { .system(size: size, weight: .bold, design: .rounded) }
    static func titleMedium(_ size: CGFloat = 17) -> Font { .system(size: size, weight: .semibold, design: .rounded) }
    static func body(_ size: CGFloat = 15) -> Font { .system(size: size, weight: .regular, design: .rounded) }
    static func caption(_ size: CGFloat = 12) -> Font { .system(size: size, weight: .medium, design: .rounded) }
    static func label(_ size: CGFloat = 11) -> Font { .system(size: size, weight: .semibold, design: .rounded) }
}
