//
//  BookmarkView.swift
//  NewsApp
//
//  Created by Puneet on 01/12/24.
//

import SwiftUI

struct BookmarkView: View {
    
    @EnvironmentObject var bookmarkViewModel: BookmarkViewModel
    @State var searchText: String = ""
    
    var body: some View {
        let articles = self.articles
        
        NavigationView {
            ArticlesListView(articles: articles)
                .overlay(overlayView(isEmpty: articles.isEmpty))
                .navigationTitle("Saved Articles")
        }
        .searchable(text: $searchText)
    }
    
    private var articles: [Article] {
        if searchText.isEmpty {
            return bookmarkViewModel.bookmarks
        }
        return bookmarkViewModel.bookmarks
            .filter {
                $0.title.lowercased().contains(searchText.lowercased()) ||
                $0.descriptionText.lowercased().contains(searchText.lowercased())
            }
    }
    
    @ViewBuilder
    func overlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            PlaceHolderView(text: "No saved articles", image: Image(systemName: "bookmark"))
        }
    }
}

#Preview {
    BookmarkView()
        .environmentObject(BookmarkViewModel.shared)
}
