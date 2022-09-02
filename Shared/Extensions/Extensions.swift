//
//  Extensions.swift
//  CodeSamples
//
//  Created by Elvis Mwenda on 02/09/2022.
//

import SwiftUI
public extension Color {
    static let dropDownGray = hex(0xfafafc)
    static let lightGray = hex(0xeaeaea)
    static func hex(_ hex: UInt) -> Self {
        Self(
            red: Double((hex & 0xff0000) >> 16) / 255,
            green: Double((hex & 0x00ff00) >> 8) / 255,
            blue: Double(hex & 0x0000ff) / 255,
            opacity: 1
        )
    }
}
