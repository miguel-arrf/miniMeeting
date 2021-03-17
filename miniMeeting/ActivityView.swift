//
//  ActivityView.swift
//  miniMeeting
//
//  Created by https://swiftui.gallery/uploads/code/ShareSheet.html
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {

    let activityItems: [Any]
    let applicationActivities: [UIActivity]?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems,
                                        applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController,
                                context: UIViewControllerRepresentableContext<ActivityView>) {

    }
}

struct ContentView_ActivityView: View {
    @State private var showingSheet = false

    var body: some View {
        Button(action: {
            self.showingSheet = true
        }) {
            Text("Share")
        }
        .sheet(isPresented: $showingSheet,
               content: {
                ActivityView(activityItems: [NSURL(string: "https://swiftui.gallery")!] as [Any], applicationActivities: nil) })
    }
}
