//
//  FlexibleView.swift
//  CodeSamples (iOS)
//
//  Created by Elvis Mwenda on 28/09/2022.
//

import SwiftUI

/// Facade of our view, its main responsibility is to get the available width
/// and pass it down to the real implementation, `_FlexibleView`.
public struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    public let data: Data
    public let spacing: CGFloat
    public let alignment: HorizontalAlignment
    public let content: (Data.Element) -> Content
    @State private var availableWidth: CGFloat = 0

    public var body: some View {
        ZStack(alignment: Alignment(horizontal: alignment, vertical: .center)) {
            Color.clear
                .frame(height: 1)
                .readSize { size in
                    availableWidth = size.width
                }

            _FlexibleView(
                availableWidth: availableWidth,
                data: data,
                spacing: spacing,
                alignment: alignment,
                content: content
            )
        }
    }
}
