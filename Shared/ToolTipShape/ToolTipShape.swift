import SwiftUI

public struct ToolTipShape: Shape {
    public let corners: UIRectCorner
    public let radius: CGFloat
    public var toolTipPosition: ToolTipPosition
    public func path(in rect: CGRect) -> Path {
        let newOrigin = CGPoint(x: rect.origin.x + 16, y: rect.origin.y + 16)
        let newRect = CGRect(origin: newOrigin, size: .init(width: rect.width - 32, height: rect.height - 32))
        let path = Path(roundedRect: newRect, cornerRadius: radius, style: .circular)
        var newPath = Path()
        newPath.addPath(path)
        switch toolTipPosition {
        case .top(let xMultiplier, let xConstant):
            let xPosition = CGFloat(round(newRect.maxX - (newRect.maxX * xMultiplier)))
            newPath.move(to: .init(x: xPosition, y: rect.minY))
            newPath.addLine(to: .init(x: xPosition - xConstant, y: newRect.minY))
            newPath.addLine(to: .init(x: xPosition + xConstant, y: newRect.minY))
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
        return newPath
    }
}

public enum ToolTipPosition {
    case top(xPositionMultiplier: CGFloat, _ xConstant: CGFloat)
    case bottom(xPositionMultiplier: CGFloat, _ xConstant: CGFloat)
    case leading(_ yConstant: CGFloat)
    case trailing(_ yConstant: CGFloat)
    func sampleType() -> ToolTipPosition {
        switch self {
        case .top:
            return .top(xPositionMultiplier: 0.05, 10)
        case .bottom:
            return .bottom(xPositionMultiplier: 0.1, 10)
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
            toolTipPosition: .bottom(xPositionMultiplier: 0.1, 10)
        )
    }
}

