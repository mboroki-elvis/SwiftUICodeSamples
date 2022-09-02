//
//  SampleTransition.swift
//  CustomShapes
//
//  Created by Elvis Mwenda on 02/09/2022.
//

import SwiftUI

struct SampleTransition: View {
    @State private var isLeftToRight = true
    @State private var showView: Bool = false
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center) {
                Toggle("Toggle Left to right", isOn: $isLeftToRight)
                    .frame(width: 200, height: 50)
                    .padding()
                Button("handle") {
                    showView = true
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .rightSheet(isPresented: $showView, transitionType: .ratio(0.4)) {
                SampleView(showView: $showView)
            }
            .environment(\.layoutDirection,
                         isLeftToRight ? .leftToRight : .rightToLeft)
        }
    }
}

struct SampleTransition_Preview: PreviewProvider {
    static var previews: some View {
        SampleTransition()
    }
}
