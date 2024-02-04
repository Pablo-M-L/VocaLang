//
//  WebView.swift
//  VocaLang
//
//  Created by pablo millan lopez on 29/1/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable{
    
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: URL(string: url)!))
    }
    
    
}

