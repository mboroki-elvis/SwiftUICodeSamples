import SwiftUI

struct DropDown: View {
    @State private var isHidden = true
    var body: some View {
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
                        .foregroundColor(.black)
                }
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            }
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.blue, lineWidth: 1)
            )
            .padding()
            Spacer().frame(height: 4)
            VStack {
                Spacer()
                ForEach(0 ..< 5) { item in
                    HStack {
                        Spacer().frame(width: 8)
                        VStack {
                            Text("\(item) some item here")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .opacity(isHidden ? 0 : 1)
                                .aspectRatio(1, contentMode: .fill)
                            if item != 4 {
                                Color.borderColor.opacity(isHidden ? 0 : 1).frame(height: 0.5)
                            }
                        }
                        Spacer().frame(width: 8)
                    }
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }
                Spacer()
            }
            .frame(height: isHidden ? 0 : 230)
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

struct DropDown_Previews: PreviewProvider {
    static var previews: some View {
        DropDown()
    }
}
