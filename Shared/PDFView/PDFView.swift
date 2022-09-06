//

//  ContentView.swift

//  SwiftUIPDFDemo

//

//  Created by Ashwin Mangrulkar on 2022/09/05.

//

import SwiftUI

struct ContentView: View {
    let fileUrl = Bundle.main.url(forResource: "sample", withExtension: "pdf")!
    let pub = NotificationCenter.default.publisher(for: Notification.Name.PDFViewPageChanged)
    private func performPageCheck(_ output: NotificationCenter.Publisher.Output) {
        if let object = output.object as? PDFView,
           let document = object.document
        {
            if let currentPage = object.currentPage?.pageRef?.pageNumber {
                if currentPage == document.pageCount {
                    withAnimation {
                        showButtons = true
                    }
                    print("last page: \(document.pageCount)")
                } else {
                    print("currentPage: \(currentPage)")
                }
            }
        }
    }

    @State var showButtons = false
    var body: some View {
        GeometryReader { geometry in
            VStack {
                PDFKitView(url: self.fileUrl)
                    .onReceive(pub, perform: { output in
                        performPageCheck(output)
                    })
                    .frame(
                        width: geometry.size.width,
                        height: showButtons ? geometry.size.height * 0.9 : geometry.size.height,
                        alignment: .center
                    )

                if showButtons {
                    HStack(alignment: .center, spacing: 10) {
                        Button {
                            print("action 1")

                        } label: {
                            Text("Reject")
                                .padding()
                        }
                        .frame(height: 50)
                        .background()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.blue, lineWidth: 2)
                        )
                        .padding()

                        Button {
                            print("action 2")

                        } label: {
                            Text("Accept")
                                .padding()
                                .foregroundColor(.white)
                        }
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(8)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

import PDFKit

struct PDFKitView: View {
    var url: URL

    var body: some View {
        PDFKitRepresentedView(url)
    }
}

struct PDFKitRepresentedView: UIViewRepresentable {
    let url: URL

    init(_ url: URL) {
        self.url = url
    }

    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
        let pdfView = PDFView()
        let document = PDFDocument(url: url)

        pdfView.document = document

        pdfView.autoScales = true

        return pdfView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {
        // Update the view.
    }
}
