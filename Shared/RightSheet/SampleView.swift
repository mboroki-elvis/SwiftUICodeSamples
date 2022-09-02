//
//  SampleView.swift
//  CustomShapes
//
//  Created by Elvis Mwenda on 02/09/2022.
//

import SwiftUI

struct SampleView: View {
    @Binding var showView: Bool
    @State var xOffset: CGFloat = 0
    @State var yOffset: CGFloat = 0
    @State var showToolTip: Bool = false
    private var textString: String {
        """
        An automated link will be sent to the email address entered and customer can complete the activation of the email within 24 hours post onboarding.
        No communication should be sent to customer as long as the activation link has not been validated by the customer.
        """
    }

    @State var sometext: String = ""
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center) {
                HStack{
                    Spacer()
                    Button {
                        showView = false
                    } label: {
                        Image(systemName: "xmark").foregroundColor(.black)
                    }
                    .frame(width: 32, height: 32)
                    .padding([.trailing, .top], 32)
                }
                Spacer().frame(height: 50)
                ForEach(0 ..< 6) { i in
                    HStack(alignment: .center) {
                        Spacer()
                        TextField("Some texfield \(i)", text: $sometext)
                            .frame(width: geo.size.width * 0.9, height: 40)
                        Spacer()
                    }
                }
                .padding()
                GeometryReader { georeader in
                    let frame = georeader.frame(in: .global)
                    HStack(alignment: .center) {
                        Spacer()
                        Button {
                            showToolTip.toggle()
                        } label: {
                            Text("Show item \(frame.size.width)")
                                .padding()
                        }
                        .frame(height: 50)
                        .background(Color.green)
                        .cornerRadius(8)
                        .overlay {
                            if showToolTip {
                                VStack(spacing: 16) {
                                    Spacer().frame(height: 20)
                                    HStack {
                                        Text("Email Information")
                                            .font(.system(size: 14, weight: .bold))
                                        Spacer()
                                        Button {
                                            showToolTip.toggle()
                                        } label: {
                                            Image(systemName: "xmark").foregroundColor(.black)
                                        }
                                    }
                                    .padding([.leading, .trailing], 32)
                                    Text(textString)
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(Color.black)
                                        .padding([.leading, .trailing], 32)
                                    Spacer().frame(height: 20)
                                }
                                .frame(width: frame.width * 0.8, height: 247)
                                .background(Color.dropDownGray)
                                .clipShape(ToolTipShape(corners: .allCorners, radius: 8, toolTipPosition: .bottom(xPositionMultiplier: 0.1, 10)))
                                .flipsForRightToLeftLayoutDirection(true)
                                .shadow(color: .lightGray, radius: 8)
                                .position(x: frame.width / 4, y: -247 / 2)
                            }
                        }
                        Spacer()
                    }
                    
                }
                Spacer()
            }
            .background(Color.white)
            .shadow(color: .lightGray, radius: 8, x: 1, y: 1)
        }
    }
}
