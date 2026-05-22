import SwiftUI

// Animated parabolic jump trajectory visualization.
struct JumpTrajectoryView: View {

    var accentColor: Color = AppDesign.Colors.electricLime
    var animating = true

    @State private var phase: Double = 0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        Canvas { context, size in
            drawTrajectory(context: context, size: size)
            drawJumperDot(context: context, size: size)
        }
        .onAppear {
            guard !reduceMotion else { phase = 0.5; return }
            withAnimation(.linear(duration: 1.8).repeatForever(autoreverses: false)) {
                phase = 1
            }
        }
        .accessibilityHidden(true)
    }

    // MARK: - Drawing

    private func drawTrajectory(context: GraphicsContext, size: CGSize) {
        var path = Path()
        let steps = 60
        for i in 0...steps {
            let t = Double(i) / Double(steps)
            let pt = pointOnArc(t: t, in: size)
            if i == 0 { path.move(to: pt) } else { path.addLine(to: pt) }
        }
        context.stroke(
            path,
            with: .linearGradient(
                Gradient(colors: [accentColor.opacity(0.15), accentColor, accentColor.opacity(0.15)]),
                startPoint: CGPoint(x: 0, y: size.height),
                endPoint: CGPoint(x: size.width, y: size.height)
            ),
            lineWidth: 2
        )
    }

    private func drawJumperDot(context: GraphicsContext, size: CGSize) {
        let t = reduceMotion ? 0.5 : phase.truncatingRemainder(dividingBy: 1.0)
        let pt = pointOnArc(t: t, in: size)
        let radius: CGFloat = 7
        let dotRect = CGRect(x: pt.x - radius, y: pt.y - radius, width: radius * 2, height: radius * 2)

        // Glow
        var glowCtx = context
        glowCtx.opacity = 0.4
        glowCtx.fill(Path(ellipseIn: dotRect.insetBy(dx: -6, dy: -6)), with: .color(accentColor))

        // Dot
        context.fill(Path(ellipseIn: dotRect), with: .color(accentColor))
    }

    private func pointOnArc(t: Double, in size: CGSize) -> CGPoint {
        let x = t * size.width
        let heightFraction: Double = 4 * t * (1 - t)   // parabola peaks at t=0.5
        let y = size.height - heightFraction * size.height * 0.85
        return CGPoint(x: x, y: y)
    }
}

#Preview {
    JumpTrajectoryView()
        .frame(height: 120)
        .padding()
        .background(AppDesign.Colors.surface1)
        .clipShape(.rect(cornerRadius: AppDesign.Radius.lg))
}
