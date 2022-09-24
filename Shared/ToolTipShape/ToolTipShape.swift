import SwiftUI

public struct ToolTipShape: Shape {
    public let corners: UIRectCorner
    public let radius: CGFloat
    public var toolTipHeight: CGFloat
    public let toolWidth: CGFloat
    public var toolTipPosition: ToolTipPosition
    public var insetAmount: CGFloat = 0
    public func path(in rect: CGRect) -> Path {
        let newOrigin = CGPoint(x: rect.origin.x + toolWidth, y: rect.origin.y + toolTipHeight)
        let newRect = CGRect(origin: newOrigin, size: .init(width: rect.width - toolWidth * 2, height: rect.height - toolTipHeight * 2))
        var path = Path()
        switch toolTipPosition {
        case .top(let xMultiplier, let xConstant):
            let xPosition = CGFloat(round(newRect.maxX - (newRect.maxX * xMultiplier)) - radius / 2)
            path.addRelativeArc(center: .init(x: newOrigin.x + radius, y: newOrigin.y + radius), radius: radius, startAngle: .degrees(180), delta: .degrees(90))
           
            path.addLine(to: .init(x: xPosition - xConstant, y: newRect.minY))
            path.addLine(to: .init(x: xPosition, y: rect.minY))
            path.addLine(to: .init(x: xPosition + xConstant, y: newRect.minY))
            
            path.addArc(center: .init(x: newRect.maxX - radius, y: newRect.minY + radius), radius: radius, startAngle: .degrees(270), endAngle: .degrees(0), clockwise: false)
            
            path.addLine(to: .init(x: newRect.maxX, y: newRect.minY + radius))
            path.addLine(to: .init(x: newRect.maxX, y: newRect.maxY - radius))
            
            path.addRelativeArc(center: .init(x: newRect.maxX - radius, y: newRect.maxY - radius), radius: radius, startAngle: .degrees(0), delta: .degrees(90))
            
            path.addLine(to: .init(x: newRect.minX + radius, y: newRect.maxY))
            
            path.addRelativeArc(center: .init(x: newRect.minX + radius, y: newRect.maxY - radius), radius: radius, startAngle: .degrees(90), delta: .degrees(90))
            
            path.addLine(to: .init(x: newRect.minX, y: newRect.minY + radius))
        case .bottom(let xMultiplier, let xConstant):
            let xPosition = CGFloat(round(newRect.maxX - (newRect.maxX * xMultiplier)) - radius / 2)
            path.addRelativeArc(center: .init(x: newOrigin.x + radius, y: newOrigin.y + radius), radius: radius, startAngle: .degrees(180), delta: .degrees(90))
            
            path.addLine(to: .init(x: newRect.maxX - radius, y: newRect.minY))
            path.addArc(center: .init(x: newRect.maxX - radius, y: newRect.minY + radius), radius: radius, startAngle: .degrees(270), endAngle: .degrees(0), clockwise: false)
            path.addLine(to: .init(x: newRect.maxX, y: newRect.maxY - radius))
            
            path.addArc(center: .init(x: newRect.maxX - radius, y: newRect.maxY - radius), radius: radius, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
            
            path.addLine(to: CGPoint(x: xPosition + xConstant, y: newRect.maxY))
            path.addLine(to: .init(x: xPosition, y: rect.maxY))
            path.addLine(to: CGPoint(x: xPosition - xConstant, y: newRect.maxY))
   
            path.addLine(to: .init(x: newRect.minX + radius, y: newRect.maxY))
            path.addRelativeArc(center: .init(x: newRect.minX + radius, y: newRect.maxY - radius), radius: radius, startAngle: .degrees(90), delta: .degrees(90))
            path.addLine(to: .init(x: newRect.minX, y: newRect.minY + radius))
        case .leading(let yConstant):
            path.addRelativeArc(center: .init(x: newOrigin.x + radius, y: newOrigin.y + radius), radius: radius, startAngle: .degrees(180), delta: .degrees(90))
            
            path.addLine(to: .init(x: newRect.maxX - radius, y: newRect.minY))
            path.addArc(center: .init(x: newRect.maxX - radius, y: newRect.minY + radius), radius: radius, startAngle: .degrees(270), endAngle: .degrees(0), clockwise: false)
            path.addLine(to: .init(x: newRect.maxX, y: newRect.maxY - radius))
            
            path.addRelativeArc(center: .init(x: newRect.maxX - radius, y: newRect.maxY - radius), radius: radius, startAngle: .degrees(0), delta: .degrees(90))
            
            path.addLine(to: .init(x: newRect.minX + radius, y: newRect.maxY))
            
            path.addRelativeArc(center: .init(x: newRect.minX + radius, y: newRect.maxY - radius), radius: radius, startAngle: .degrees(90), delta: .degrees(90))
            path.addLine(to: .init(x: newRect.minX, y: newRect.midY + yConstant))
            path.addLine(to: .init(x: rect.minX, y: newRect.midY))
            path.addLine(to: .init(x: newRect.minX, y: newRect.midY - yConstant))
            path.addLine(to: .init(x: newRect.minX, y: newRect.minY + radius))
        case .trailing(let yConstant):
            path.addRelativeArc(center: .init(x: newOrigin.x + radius, y: newOrigin.y + radius), radius: radius, startAngle: .degrees(180), delta: .degrees(90))
            
            path.addLine(to: .init(x: newRect.maxX - radius, y: newRect.minY))
            path.addArc(center: .init(x: newRect.maxX - radius, y: newRect.minY + radius), radius: radius, startAngle: .degrees(270), endAngle: .degrees(0), clockwise: false)
           
            path.addLine(to: CGPoint(x: newRect.maxX, y: rect.midY - yConstant))
            path.addLine(to: .init(x: rect.maxX, y: newRect.midY))
            path.addLine(to: CGPoint(x: newRect.maxX, y: rect.midY + yConstant))
            path.addLine(to: .init(x: newRect.maxX, y: newRect.maxY - radius))
            
            path.addRelativeArc(center: .init(x: newRect.maxX - radius, y: newRect.maxY - radius), radius: radius, startAngle: .degrees(0), delta: .degrees(90))
            
            path.addLine(to: .init(x: newRect.minX + radius, y: newRect.maxY))
            path.addRelativeArc(center: .init(x: newRect.minX + radius, y: newRect.maxY - radius), radius: radius, startAngle: .degrees(90), delta: .degrees(90))
            path.addLine(to: .init(x: newRect.minX, y: newRect.minY + radius))
        }
        return path
    }
}

extension ToolTipShape: InsettableShape {
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

public enum ToolTipPosition {
    case top(xPositionMultiplier: CGFloat, _ xConstant: CGFloat)
    case bottom(xPositionMultiplier: CGFloat, _ xConstant: CGFloat)
    case leading(_ yConstant: CGFloat)
    case trailing(_ yConstant: CGFloat)
    enum Position {
        case top
        case bottom
        case leading
        case trailing
    }

    static func position(_ position: Position) -> ToolTipPosition {
        switch position {
        case .top:
            return .top(xPositionMultiplier: 0.05, 10)
        case .bottom:
            return .bottom(xPositionMultiplier: 0.05, 10)
        case .leading:
            return .leading(15)
        case .trailing:
            return .trailing(15)
        }
    }
}

struct ToolTipTopView_Previews: PreviewProvider {
    static var previews: some View {
        ToolTipShape(
            corners: .allCorners,
            radius: 8,
            toolTipHeight: 16,
            toolWidth: 16,
            toolTipPosition: .position(.topA)
        )
    }
}
