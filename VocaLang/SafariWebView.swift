//
//  SafariWebView.swift
//  VocaLang
//
//  Created by pablo millan lopez on 29/1/24.
//

import SwiftUI
import SafariServices

struct SafariWebView: UIViewControllerRepresentable{
    let url: String
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: URL(string: url)!)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
    
    
}

