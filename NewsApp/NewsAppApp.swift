//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Puneet on 27/11/24.
//

import SwiftUI

@main
struct NewsAppApp: App {
    
    @StateObject var bookmarkViewModel = BookmarkViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bookmarkViewModel)
        }
    }
}
