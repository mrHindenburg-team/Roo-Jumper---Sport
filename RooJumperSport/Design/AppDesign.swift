import SwiftUI

enum AppDesign {

    // MARK: - Colors

    enum Colors {
        static let background     = Color(red: 0.04, green: 0.04, blue: 0.07)
        static let surface1       = Color(red: 0.09, green: 0.09, blue: 0.13)
        static let surface2       = Color(red: 0.13, green: 0.14, blue: 0.19)
        static let surface3       = Color(red: 0.18, green: 0.19, blue: 0.26)
        static let electricLime   = Color(red: 0.76, green: 0.99, blue: 0.0)
        static let neonOrange     = Color(red: 1.0,  green: 0.44, blue: 0.0)
        static let dynamicBlue    = Color(red: 0.05, green: 0.60, blue: 1.0)
        static let neonCyan       = Color(red: 0.0,  green: 0.93, blue: 0.93)
        static let brightWhite    = Color.white
        static let dimWhite       = Color.white.opacity(0.55)
        static let mutedText      = Color.white.opacity(0.35)
        static let graphite       = Color(red: 0.24, green: 0.25, blue: 0.30)

        // Gradients
        static var explosiveness: LinearGradient {
            LinearGradient(
                colors: [electricLime, neonOrange],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
        }
        static var motion: LinearGradient {
            LinearGradient(
                colors: [dynamicBlue, neonCyan],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
        }
        static var stadium: LinearGradient {
            LinearGradient(
                colors: [background, surface1],
                startPoint: .top, endPoint: .bottom
            )
        }
        static var energy: LinearGradient {
            LinearGradient(
                colors: [electricLime.opacity(0.9), dynamicBlue.opacity(0.8)],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
        }
        static var cardSurface: LinearGradient {
            LinearGradient(
                colors: [surface2, surface1],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
        }
        static var aiCoach: LinearGradient {
            LinearGradient(
                colors: [Color(red: 0.35, green: 0.0, blue: 0.85), dynamicBlue],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
        }
    }

    // MARK: - Typography

    enum Typography {
        static let display  = Font.system(.largeTitle, design: .rounded, weight: .black)
        static let headline = Font.system(.title,      design: .rounded, weight: .bold)
        static let title    = Font.system(.title2,     design: .rounded, weight: .semibold)
        static let title3   = Font.system(.title3,     design: .rounded, weight: .semibold)
        static let body     = Font.system(.body,       design: .rounded)
        static let label    = Font.system(.footnote,   design: .rounded, weight: .medium)
        static let caption  = Font.system(.caption,    design: .rounded)
    }

    // MARK: - Spacing

    enum Spacing {
        static let xs:  CGFloat = 4
        static let sm:  CGFloat = 8
        static let md:  CGFloat = 16
        static let lg:  CGFloat = 24
        static let xl:  CGFloat = 32
        static let xxl: CGFloat = 48
        static let xxxl: CGFloat = 64
    }

    // MARK: - Corner Radius

    enum Radius {
        static let sm:   CGFloat = 8
        static let md:   CGFloat = 16
        static let lg:   CGFloat = 24
        static let xl:   CGFloat = 32
        static let full: CGFloat = 9999
    }

    // MARK: - Shadows

    static func glowShadow(_ color: Color, radius: CGFloat = 16) -> some ViewModifier {
        GlowShadowModifier(color: color, radius: radius)
    }

    // MARK: - Animation

    enum Anim {
        static let fast      = SwiftUI.Animation.easeOut(duration: 0.18)
        static let standard  = SwiftUI.Animation.easeInOut(duration: 0.32)
        static let slow      = SwiftUI.Animation.easeInOut(duration: 0.55)
        static let bounce    = SwiftUI.Animation.spring(response: 0.38, dampingFraction: 0.62)
        static let energetic = SwiftUI.Animation.spring(response: 0.28, dampingFraction: 0.52)
        static let cinematic = SwiftUI.Animation.easeInOut(duration: 1.1)
    }
}

// MARK: - GlowShadowModifier

private struct GlowShadowModifier: ViewModifier {
    let color: Color
    let radius: CGFloat

    func body(content: Content) -> some View {
        content
            .shadow(color: color.opacity(0.55), radius: radius / 2, x: 0, y: 0)
            .shadow(color: color.opacity(0.28), radius: radius,     x: 0, y: 0)
    }
}

// MARK: - Convenience Extensions

extension View {
    func glowShadow(_ color: Color, radius: CGFloat = 16) -> some View {
        modifier(AppDesign.glowShadow(color, radius: radius))
    }

    func sportCard() -> some View {
        self
            .padding(AppDesign.Spacing.md)
            .background(AppDesign.Colors.cardSurface)
            .clipShape(.rect(cornerRadius: AppDesign.Radius.lg))
            .overlay {
                RoundedRectangle(cornerRadius: AppDesign.Radius.lg)
                    .strokeBorder(AppDesign.Colors.surface3, lineWidth: 1)
            }
    }
}
