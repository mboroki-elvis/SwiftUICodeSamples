import SwiftUI

struct AppView: View {
    @State private var isRightSheet = true
    @State private var showView: Bool = false
    @State private var showDropDown: Bool = false
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center) {
                Toggle(
                    "Toggle Direction",
                    isOn: $isRightSheet
                )
                .frame(width: 200, height: 50)
                .padding()
                Button("Show Right Sheet") {
                    showView = true
                }
                Spacer().frame(height: 30)
                Button("Show Right Drop Down") {
                    showDropDown = true
                }
                
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .rightSheet(isPresented: $showView, transitionType: .ratio(0.5)) {
                TransitionView(showView: $showView)
            }.background(content: {
                showView ? Color.black.opacity(0.3) : Color.clear
            })
            .sheet(isPresented: $showDropDown, onDismiss: {
                showDropDown = false
            }, content: {
                SampleDropDownView()
            })
            .environment(\.layoutDirection,
                         isRightSheet ? .leftToRight : .rightToLeft)
        }
    }
}

struct SampleTransition_Preview: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
