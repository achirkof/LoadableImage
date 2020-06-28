//
//  ActivityIndicator.swift
//
//  Created by CHIRKOV Andrey on 12.01.2020.
//

import SwiftUI

@available(iOS 13.0.0, macOS 10.15, *)
struct ProgressIndicator: View {
    public var body: some View {
        if #available(iOS 14.0, *) {
            return AnyView(ProgressView())
        } else {
            return AnyView(ActivityIndicator(isAnimating: true))
        }
    }
}

public struct ActivityIndicator: UIViewRepresentable {
    public typealias UIView = UIActivityIndicatorView

    private var isAnimating: Bool

    fileprivate var configuration = { (_: UIView) in }

    public init(
        isAnimating: Bool
    ) {
        self.isAnimating = isAnimating
    }

    public func makeUIView(context: UIViewRepresentableContext<Self>) -> UIView { UIView() }

    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Self>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        configuration(uiView)
    }
}
