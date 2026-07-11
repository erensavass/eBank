import SwiftUI

public struct PieSliceView: View {
    public let startAngle: Angle
    public let endAngle: Angle
    public let color: Color

    public init(startAngle: Angle, endAngle: Angle, color: Color) {
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.color = color
    }

    public var body: some View {
        GeometryReader { geometry in
            Path { path in
                let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                let radius = min(geometry.size.width, geometry.size.height) / 2
                let innerRadius = radius * 0.8 // İç yarıçap

                path.move(to: center)
                path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                path.addArc(center: center, radius: innerRadius, startAngle: endAngle, endAngle: startAngle, clockwise: true)
                path.closeSubpath()
            }
            .fill(color)
        }
    }
}
