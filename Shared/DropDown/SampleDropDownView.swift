import SwiftUI

struct SampleDropDownView: View {
    @State private var isHidden = true
    @State private var someText: String = ""
    var body: some View {
        GeometryReader { _ in
            VStack {
                Spacer().frame(height: 30)
                ForEach(0 ..< 10) { i in
                    TextField("\(i) Please fille in the following", text: $someText)
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                TextDropDown(
                    items: TextDropDownValue.sample(),
                    onItemSelected: { _ in }
                )
                Text("NB: Capture your details for processing")
                    .font(.caption)
            }
        }
    }
}
