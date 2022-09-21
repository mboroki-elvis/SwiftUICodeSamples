import SwiftUI
public extension Color {
    static let dropDownGray = hex(0xfafafc)
    static let lightGray = hex(0xeaeaea)
    static let borderColor = hex(0xCCCCCC)
    static let dropDownImage = hex(0x999999)
    static let grayText = hex(0x505D68)
    static func hex(_ hex: UInt) -> Self {
        Self(
            red: Double((hex & 0xff0000) >> 16) / 255,
            green: Double((hex & 0x00ff00) >> 8) / 255,
            blue: Double(hex & 0x0000ff) / 255,
            opacity: 1
        )
    }
}
