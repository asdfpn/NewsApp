//
//  ContentView.swift
//  NewsApp
//
//  Created by Puneet on 27/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            
            BookmarkView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
        }
    }
}

#Preview {
    ContentView()
}
