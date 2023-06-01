//
//  WebView.swift
//  StockTrading
//
//  Created by Jason Liu on 4/30/22.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @Binding var title: String
    var fileSource: String
    var jsString: String
    var loadStatusChanged: ((Bool, Error?) -> Void)? = nil

    func makeCoordinator() -> WebView.Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.navigationDelegate = context.coordinator
        let htmlFile = Bundle.main.path(forResource: fileSource, ofType: "html")
        let htmlString = try? String(contentsOfFile: htmlFile!, encoding: String.Encoding.utf8)
        view.loadHTMLString(htmlString!, baseURL: nil)
        
        return view
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // you can access environment via context.environment here
        // Note that this method will be called A LOT
//        let request = URLRequest(url: url)
//        uiView.load(request)
    }

    func onLoadStatusChanged(perform: ((Bool, Error?) -> Void)?) -> some View {
        var copy = self
        copy.loadStatusChanged = perform
        return copy
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            parent.loadStatusChanged?(true, nil)
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.title = webView.title ?? ""
            parent.loadStatusChanged?(false, nil)
            webView.evaluateJavaScript(parent.jsString) { (result, error) in
                print(self.parent.jsString)
                print(result)
                print(error)
            }
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.loadStatusChanged?(false, error)
        }
    }
}


