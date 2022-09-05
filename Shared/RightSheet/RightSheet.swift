//
//  RightSheet.swift
//  CustomShapes
//
//  Created by Elvis Mwenda on 02/09/2022.
//

import SwiftUI

struct RightSheetModifier<ViewContent: View>: ViewModifier {
    let viewContent: ViewContent
    let isPresented: Bool
    let transitionType: RightTransitonType
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { geo in
                    let config = transitionType.config(width: geo.size.width)
                    if isPresented {
                        viewContent
                            .background(Color.white)
                            .shadow(color: .lightGray, radius: 8, x: 1, y: 1)
                            .frame(width: config.width, height: geo.size.height)
                            .position(x: config.xPosition, y: geo.size.height / 2)
                            .transition(.move(edge: .trailing))
                    } else {
                        EmptyView()
                    }
                }
            }.animation(.easeInOut, value: isPresented)
    }
}

enum RightTransitonType {
    case medium
    case ratio(_ ratio: CGFloat)
    case fullscreen

    func config(width: CGFloat) -> (width: CGFloat, xPosition: CGFloat) {
        switch self {
        case .medium:
            return (width: width / 2, xPosition: width * 0.75)
        case .ratio(let ratio):
            let newWidth = width * ratio
            return (width: newWidth, xPosition: width - (newWidth / 2))
        case .fullscreen:
            return (width: width, xPosition: width * 0.5)
        }
    }
}

extension View {
    func rightSheet<Content>(
        isPresented: Binding<Bool>,
        transitionType: RightTransitonType,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View {
        modifier(RightSheetModifier(
            viewContent: content(),
            isPresented: isPresented.wrappedValue,
            transitionType: transitionType
        ))
    }
}
