import SwiftUI

public struct SampleToolTipShape: Shape {
    public let corners: UIRectCorner
    public let radius: CGFloat
    public var toolTipHeight: CGFloat
    public let toolWidth: CGFloat
    public var toolTipPosition: ToolTipPosition
    public var insetAmount: CGFloat = 0
    public func path(in rect: CGRect) -> Path {
        let newOrigin = CGPoint(x: rect.origin.x + toolWidth, y: rect.origin.y + toolTipHeight)
        let newRect = CGRect(origin: newOrigin, size: .init(width: rect.width - toolWidth * 2, height: rect.height - toolTipHeight * 2))
        var newPath = Path()
        switch toolTipPosition {
        case .top(let xMultiplier, let xConstant):
            let xPosition = CGFloat(round(newRect.maxX - (newRect.maxX * xMultiplier)) - radius / 2)
            newPath.addRelativeArc(center: .init(x: newOrigin.x + radius, y: newOrigin.y + radius), radius: radius, startAngle: .degrees(180), delta: .degrees(90))
           
            newPath.addLine(to: .init(x: xPosition - xConstant, y: newRect.minY))
            newPath.addLine(to: .init(x: xPosition, y: rect.minY))
            newPath.addLine(to: .init(x: xPosition + xConstant, y: newRect.minY))
            
            newPath.addRelativeArc(center: .init(x: newRect.maxX - radius, y: newRect.minY + radius), radius: radius, startAngle: .degrees(180), delta: .degrees(180))
            
            newPath.addLine(to: .init(x: newRect.maxX, y: newRect.minY + radius))
            newPath.addLine(to: .init(x: newRect.maxX, y: newRect.maxY - radius))
            
            newPath.addRelativeArc(center: .init(x: newRect.maxX - radius, y: newRect.maxY - radius), radius: radius, startAngle: .degrees(0), delta: .degrees(90))
            
            newPath.addLine(to: .init(x: newRect.minX + radius, y: newRect.maxY))
            
            newPath.addRelativeArc(center: .init(x: newRect.minX + radius, y: newRect.maxY - radius), radius: radius, startAngle: .degrees(90), delta: .degrees(90))
            
            newPath.addLine(to: .init(x: newRect.minX, y: newRect.minY + radius))
        case .bottom(let xMultiplier, let xConstant):
            let xPosition = CGFloat(round(newRect.maxX - (newRect.maxX * xMultiplier)))
            newPath.move(to: .init(x: xPosition, y: rect.maxY))
            newPath.addLine(to: CGPoint(x: xPosition - xConstant, y: newRect.maxY))
            newPath.addLine(to: CGPoint(x: xPosition + xConstant, y: newRect.maxY))
        case .leading(let yConstant):
            newPath.move(to: .init(x: rect.minX, y: newRect.midY))
            newPath.addLine(to: .init(x: newRect.minX, y: newRect.midY + yConstant))
            newPath.addLine(to: .init(x: newRect.minX, y: newRect.midY - yConstant))
        case .trailing(let yConstant):
            newPath.move(to: .init(x: rect.maxX, y: newRect.midY))
            newPath.addLine(to: CGPoint(x: newRect.maxX, y: rect.midY + yConstant))
            newPath.addLine(to: CGPoint(x: newRect.maxX, y: rect.midY - yConstant))
        }
        newPath.closeSubpath()
        return newPath
    }
}

extension SampleToolTipShape: InsettableShape {
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct SampleToolTipShape_Previews: PreviewProvider {
    static var previews: some View {
        SampleToolTipShape(
            corners: .allCorners,
            radius: 16,
            toolTipHeight: 16,
            toolWidth: 16,
            toolTipPosition: .top(xPositionMultiplier: 0.05, 10)
        )
    }
}
