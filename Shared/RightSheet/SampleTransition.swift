//
//  SampleTransition.swift
//  CustomShapes
//
//  Created by Elvis Mwenda on 02/09/2022.
//

import SwiftUI

struct SampleTransition: View {
    @State private var isRightSheet = true
    @State private var showView: Bool = false
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center) {
                Toggle("Toggle Direction", isOn: $isRightSheet)
                    .frame(width: 200, height: 50)
                    .padding()
                Button("Show Right Sheet") {
                    showView = true
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .rightSheet(isPresented: $showView, transitionType: .ratio(0.5)) {
                SampleView(showView: $showView)
            }.background(content: {
                showView ? Color.black.opacity(0.3) : Color.clear
            })
            .environment(\.layoutDirection,
                         isRightSheet ? .leftToRight : .rightToLeft)
        }
    }
}

struct SampleTransition_Preview: PreviewProvider {
    static var previews: some View {
        SampleTransition()
    }
}
