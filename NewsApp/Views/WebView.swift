//
//  WebView.swift
//  NewsApp
//
//  Created by Puneet on 29/11/24.
//

import SwiftUI
import SafariServices


struct WebView: UIViewControllerRepresentable {
    
    let url: URL
    
    func makeUIViewController(context: Context) -> some SFSafariViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

#Preview {
    WebView(url: URL(string: "https://google.com")!)
}
