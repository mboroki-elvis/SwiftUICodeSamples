import SwiftUI
public extension AttributedString {
    func fontAttribute(
        range of: String,
        font: Font
    ) -> AttributedString {
        var attributedString = self
        let range = attributedString.range(of: of)!
        attributedString[range].font = font
        return attributedString
    }
}
