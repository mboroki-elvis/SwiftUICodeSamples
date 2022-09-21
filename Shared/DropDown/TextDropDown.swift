import SwiftUI

public struct TextDropDown: View {
    @State public var isHidden = true
    @State public var items: [TextDropDownValue]
    private var contentHeight: CGFloat {
        return CGFloat(items.count * 50)
    }

    public init(isHidden: Bool = true, items: [TextDropDownValue]) {
        self.isHidden = isHidden
        self.items = items
    }

    public var body: some View {
        VStack(alignment: .leading) {
            Button {
                withAnimation {
                    isHidden.toggle()
                }
            } label: {
                HStack {
                    Text("Select")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.caption)
                        .foregroundColor(.black)
                    Image(systemName: "arrowtriangle.down.fill")
                        .frame(width: 7, height: 7)
                        .padding([.trailing], 8)
                        .foregroundColor(Color.dropDownImage)
                }
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            }
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.borderColor, lineWidth: 1)
            )
            .padding()
            Spacer().frame(height: isHidden ? 0 : 4)
            VStack {
                Spacer()
                ForEach(items) { item in
                    HStack {
                        Spacer().frame(width: 8)
                        VStack {
                            Text(item.value)
                                .foregroundColor(Color.grayText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .opacity(isHidden ? 0 : 1)
                            if item.id != items.last?.id {
                                Color.borderColor.opacity(isHidden ? 0 : 1).frame(height: 0.5)
                            }
                        }
                        Spacer().frame(width: 8)
                    }
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }
                Spacer()
            }
            .frame(height: isHidden ? 0 : contentHeight)
            .opacity(isHidden ? 0 : 1)
            .animation(.easeInOut, value: isHidden)
            .background {
                ToolTipShape(
                    corners: .allCorners,
                    radius: 8,
                    toolTipHeight: 12,
                    toolWidth: 16,
                    toolTipPosition: .top(xPositionMultiplier: 0.05, 10)
                )
                .fill(Color.dropDownGray)
                ToolTipShape(
                    corners: .allCorners,
                    radius: 8,
                    toolTipHeight: 12,
                    toolWidth: 16,
                    toolTipPosition: .top(xPositionMultiplier: 0.05, 10)
                )
                .strokeBorder(Color.borderColor, lineWidth: 1)
                .opacity(isHidden ? 0 : 1)
            }
        }
    }
}

public struct TextDropDownValue: Identifiable, Hashable {
    public let id: String
    public let value: AttributedString
}

struct DropDown_Previews: PreviewProvider {
    static var previews: some View {
        TextDropDown(
            isHidden: true,
            items: [
                .init(
                    id: UUID().uuidString,
                    value: .init("KES 0 - 3 million")
                        .fontAttribute(
                            range: "KES",
                            font: .system(size: 14, weight: .bold)
                        )
                        .fontAttribute(
                            range: "0 - 3 million",
                            font: .system(size: 14, weight: .regular)
                        )
                ),
                .init(
                    id: UUID().uuidString,
                    value: .init("KES +3 - 40 million")
                        .fontAttribute(
                            range: "KES",
                            font: .system(size: 14, weight: .bold)
                        )
                        .fontAttribute(
                            range: "+3 - 40 million",
                            font: .system(size: 14, weight: .regular)
                        )
                ),
                .init(
                    id: UUID().uuidString,
                    value: .init("KES +40 - 200 million")
                        .fontAttribute(
                            range: "KES",
                            font: .system(size: 14, weight: .bold)
                        ).fontAttribute(
                            range: "+40 - 200 million",
                            font: .system(size: 14, weight: .regular)
                        )
                ),
                .init(
                    id: UUID().uuidString,
                    value: .init("KES +200 million")
                        .fontAttribute(
                            range: "KES",
                            font: .system(size: 14, weight: .bold)
                        )
                        .fontAttribute(
                            range: "+200 million",
                            font: .system(size: 14, weight: .regular)
                        )
                )
            ]
        )
    }
}


