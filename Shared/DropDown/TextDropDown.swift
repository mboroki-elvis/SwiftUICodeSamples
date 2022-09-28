import SwiftUI

public struct TextDropDown: View {
    @State private var isDropDownCollapsed: Bool
    @State private var selectedText: AttributedString
    // Required values
    @State private var items: [TextDropDownValue]
    private var isMultiSelect: Bool
    public var onItemSelected: (TextDropDownValue) -> Void
    private var contentHeight: CGFloat {
        return CGFloat(items.count * 48)
    }

    public init(
        isDropDownCollapsed: Bool = true,
        isMultiSelect: Bool = false,
        items: [TextDropDownValue],
        placeHolder: String = "Select",
        onItemSelected: @escaping (TextDropDownValue) -> Void
    ) {
        self.isMultiSelect = isMultiSelect
        self.onItemSelected = onItemSelected
        _items = State(initialValue: items)
        _selectedText = State(initialValue: .init(placeHolder))
        _isDropDownCollapsed = State(initialValue: isDropDownCollapsed)
    }

    public var body: some View {
        VStack(alignment: .leading) {
            Button {
                withAnimation {
                    isDropDownCollapsed.toggle()
                }
            } label: {
                HStack {
                    Text(selectedText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.grayText)
                    Image(systemName: "arrowtriangle.down.fill")
                        .imageScale(.small)
                        .aspectRatio(1, contentMode: .fit)
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
            Spacer().frame(height: isDropDownCollapsed ? 0 : 4)
            VStack {
                Spacer().frame(height: 8)
                ForEach(items) { item in
                    HStack {
                        Spacer().frame(width: 8)
                        VStack {
                            HStack {
                                if isMultiSelect {
                                    Image(systemName: "checkmark")
                                        .imageScale(.medium)
                                        .foregroundColor(item.isSelected ? Color.blue : Color.grayText)
                                    Spacer().frame(width: 8)
                                }
                                Text(item.value)
                                    .foregroundColor(Color.grayText)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .opacity(isDropDownCollapsed ? 0 : 1)
                            }
                            if item.id != items.last?.id {
                                Color
                                    .borderColor
                                    .opacity(
                                        isDropDownCollapsed ? 0 : 1
                                    ).frame(height: 0.5)
                            }
                        }
                        Spacer().frame(width: 8)
                    }
                    .frame(height: 32)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if isMultiSelect {
                            if let index = items.firstIndex(where: { $0.id == item.id }) {
                                items[index].isSelected.toggle()
                            }
                        } else {
                            isDropDownCollapsed.toggle()
                            selectedText = item.value
                            onItemSelected(item)
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }
                Spacer().frame(height: 8)
            }
            .frame(height: isDropDownCollapsed ? 0 : contentHeight)
            .opacity(isDropDownCollapsed ? 0 : 1)
            .animation(.easeInOut, value: isDropDownCollapsed)
            .background {
                ToolTipShape(
                    corners: .allCorners,
                    radius: 8,
                    toolTipHeight: 7,
                    toolWidth: 16,
                    toolTipPosition: .position(.top)
                )
                .strokeBorder(Color.borderColor, lineWidth: 1)
                .background(content: {
                    ToolTipShape(
                        corners: .allCorners,
                        radius: 8,
                        toolTipHeight: 7,
                        toolWidth: 16,
                        toolTipPosition: .position(.top)
                    )
                    .fill(Color.dropDownGray)
                })
                .opacity(isDropDownCollapsed ? 0 : 1)
            }
        }
    }
}

public struct TextDropDownValue: Identifiable, Hashable {
    public let id: String
    public var value: AttributedString
    public var isSelected: Bool = false
}

public extension TextDropDownValue {
    static func sample() -> [TextDropDownValue] {
        [.init(
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
        )]
    }

    static func sampleMultieSelect() -> [TextDropDownValue] {
        [.init(
            id: UUID().uuidString,
            value: .init("Payment of Obligations and Expenses")
                .fontAttribute(
                    range: "Payment of Obligations and Expenses",
                    font: .system(size: 14, weight: .regular)
                )
        ),
        .init(
            id: UUID().uuidString,
            value: .init("Deposit")
                .fontAttribute(
                    range: "Deposit",
                    font: .system(size: 14, weight: .regular)
                )
        ),
        .init(
            id: UUID().uuidString,
            value: .init("Collection of Business Proceeds")
                .fontAttribute(
                    range: "Collection of Business Proceeds",
                    font: .system(size: 14, weight: .regular)
                )
        ),
        .init(
            id: UUID().uuidString,
            value: .init("Other")
                .fontAttribute(
                    range: "Other",
                    font: .system(size: 14, weight: .regular)
                )
        )]
    }
}

struct DropDown_Previews: PreviewProvider {
    static var previews: some View {
        TextDropDown(
            isMultiSelect: true,
            items: TextDropDownValue.sampleMultieSelect(),
            onItemSelected: { _ in
            }
        )
    }
}
