//
//  SafariView.swift
//  AppleFoodPin
//
//  Created by user on 2023/1/11.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {

    var url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {

    }
}
